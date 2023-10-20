/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

use std::borrow::Cow;
use std::io::Write;

use crate::bindgen::config::{Config, DocumentationLength, DocumentationStyle, Layout};
use crate::bindgen::declarationtyperesolver::DeclarationType;
use crate::bindgen::ir::{
    to_known_assoc_constant, ConditionWrite, ConstExpr, DeprecatedNoteKind, Documentation, Enum,
    EnumVariant, Field, Function, GenericArgument, Item, Literal, OpaqueItem, Static, Struct,
    ToCondition, Type, Typedef, Union, VariantBody,
};
use crate::bindgen::language_backend::LanguageBackend;
use crate::bindgen::reserved;
use crate::bindgen::writer::{ListType, SourceWriter};
use crate::bindgen::Bindings;

// This code renders Rust types as Nim declarations. It is a Nim-specific
// re-implementation of the C declaration logic in `crate::bindgen::cdecl`.

#[allow(dead_code)]
enum NDeclarator {
    Ptr {
        is_const: bool,
        is_nullable: bool,
        is_ref: bool,
    },
    Array(String),
    Func {
        args: Vec<(Option<String>, NCdecl)>,
        layout: Layout,
        never_return: bool,
        is_return: bool,
    },
}

impl NDeclarator {
    fn is_ptr(&self) -> bool {
        matches!(self, NDeclarator::Ptr { .. } | NDeclarator::Func { .. })
    }
}

struct NCdecl {
    type_qualifers: String,
    type_name: String,
    type_generic_args: Vec<GenericArgument>,
    declarators: Vec<NDeclarator>,
    type_ctype: Option<DeclarationType>,
    deprecated: Option<String>,
}

impl NCdecl {
    fn new() -> NCdecl {
        NCdecl {
            type_qualifers: String::new(),
            type_name: String::new(),
            type_generic_args: Vec::new(),
            declarators: Vec::new(),
            type_ctype: None,
            deprecated: None,
        }
    }

    fn from_type(t: &Type, config: &Config) -> NCdecl {
        let mut cdecl = NCdecl::new();
        cdecl.build_type(t, false, false, config);
        cdecl
    }

    fn from_func_arg(t: &Type, array_length: Option<&str>, config: &Config) -> NCdecl {
        let mut cdecl = NCdecl::new();
        let length = match array_length {
            Some(l) => l,
            None => return NCdecl::from_type(t, config),
        };
        let (ty, is_const) = match t {
            Type::Ptr { ty, is_const, .. } => (ty, is_const),
            _ => unreachable!("Should never have an array length for a non pointer type {t:?}"),
        };
        let ptr_as_array = Type::Array(ty.clone(), ConstExpr::Value(length.to_string()));
        cdecl.build_type(&ptr_as_array, *is_const, false, config);
        cdecl
    }

    fn from_func(f: &Function, layout: Layout, config: &Config) -> NCdecl {
        let mut cdecl = NCdecl::new();
        cdecl.build_func(f, layout, config);
        cdecl
    }

    fn build_func(&mut self, f: &Function, layout: Layout, config: &Config) {
        let args = f
            .args
            .iter()
            .map(|arg| {
                (
                    arg.name.clone(),
                    NCdecl::from_func_arg(&arg.ty, arg.array_length.as_deref(), config),
                )
            })
            .collect();
        self.declarators.push(NDeclarator::Func {
            args,
            layout,
            never_return: f.never_return,
            is_return: true,
        });
        self.deprecated.clone_from(&f.annotations.deprecated);
        self.build_type(&f.ret, false, true, config);
    }

    fn build_type(&mut self, t: &Type, is_const: bool, is_return: bool, config: &Config) {
        match t {
            Type::Path(ref generic) => {
                assert!(
                    self.type_name.is_empty(),
                    "error generating cdecl for {t:?}"
                );
                self.type_name = nim_ident(generic.export_name()).to_string();
                assert!(
                    self.type_generic_args.is_empty(),
                    "error generating cdecl for {t:?}"
                );
                self.type_generic_args = generic.generics().to_vec();
                self.type_ctype = generic.ctype().cloned();
            }
            Type::Primitive(ref p) => {
                assert!(
                    self.type_name.is_empty(),
                    "error generating cdecl for {t:?}"
                );
                self.type_name = p.to_repr_nim(config).to_string();
            }
            Type::Ptr {
                ref ty,
                is_nullable,
                is_const: ptr_is_const,
                is_ref,
            } => match ty.as_ref() {
                Type::Primitive(_) => {
                    self.type_name = "pointer".to_string();
                }
                _ => {
                    self.declarators.push(NDeclarator::Ptr {
                        is_const,
                        is_nullable: *is_nullable,
                        is_ref: *is_ref,
                    });
                    self.build_type(ty, *ptr_is_const, false, config);
                }
            },
            Type::Array(ref t, ref constant) => {
                let len = constant.as_str().to_owned();
                self.declarators.push(NDeclarator::Array(len));
                self.build_type(t, is_const, false, config);
            }
            Type::FuncPtr {
                ref ret,
                ref args,
                is_nullable: _,
                never_return,
            } => {
                let args = args
                    .iter()
                    .map(|(ref name, ref ty)| (name.clone(), NCdecl::from_type(ty, config)))
                    .collect();
                self.declarators.push(NDeclarator::Func {
                    args,
                    layout: config.function.args,
                    never_return: *never_return,
                    is_return,
                });
                self.build_type(ret, false, true, config);
            }
        }
    }

    fn write<F: Write>(
        &self,
        out: &mut SourceWriter<F>,
        ident: Option<&str>,
        export: bool,
        is_func: bool,
        config: &Config,
    ) {
        // Write the identifier
        if let Some(ident) = ident {
            if is_func {
                out.write("proc ");
            }
            write!(out, "{}", nim_ident(ident));
            if export {
                out.write("*");
            }
        }

        // Write the type-specifier and type-qualifier first
        if !self.type_qualifers.is_empty() {
            write!(out, "{} ", self.type_qualifers);
        }

        if !self.type_generic_args.is_empty() {
            out.write("<");
            for (i, g) in self.type_generic_args.iter().enumerate() {
                if i != 0 {
                    out.write(", ");
                }
                match *g {
                    GenericArgument::Type(ref ty) => {
                        NCdecl::from_type(ty, config).write(out, None, true, false, config)
                    }
                    GenericArgument::Const(ref expr) => write!(out, "{}", expr.as_str()),
                }
            }
            out.write(">");
        }

        let mut close_return = 0;
        {
            // Write the right part of declarators after the identifier
            let mut iter = self.declarators.iter();
            let mut done_proc = is_func;

            #[allow(clippy::while_let_on_iterator)]
            while let Some(declarator) = iter.next() {
                match *declarator {
                    NDeclarator::Ptr { .. } => {}
                    NDeclarator::Array(ref _constant) => {}
                    NDeclarator::Func {
                        ref args,
                        ref layout,
                        never_return,
                        is_return,
                    } => {
                        if !done_proc {
                            if ident.is_some() {
                                out.write(": ");
                            }

                            if is_return {
                                out.write("(");
                                close_return += 1;
                            }

                            out.write("proc");
                        }
                        done_proc = false;
                        out.write("(");

                        fn write_vertical<F: Write>(
                            out: &mut SourceWriter<F>,
                            config: &Config,
                            args: &[(Option<String>, NCdecl)],
                        ) {
                            let align_length = out.line_length_for_align();
                            out.push_set_spaces(align_length);
                            for (i, (arg_ident, arg_ty)) in args.iter().enumerate() {
                                if i != 0 {
                                    out.write(",");
                                    out.new_line();
                                }

                                let arg_ident = arg_ident.as_ref().map(|x| x.as_ref());

                                arg_ty.write(out, arg_ident, false, false, config);
                            }
                            out.pop_tab();
                        }

                        fn write_horizontal<F: Write>(
                            out: &mut SourceWriter<F>,
                            config: &Config,
                            args: &[(Option<String>, NCdecl)],
                        ) {
                            for (i, (arg_ident, arg_ty)) in args.iter().enumerate() {
                                if i != 0 {
                                    out.write(", ");
                                }

                                let arg_num = format!("a{i}");
                                let arg_ident = arg_ident.as_deref().unwrap_or(&arg_num);

                                arg_ty.write(
                                    out,
                                    Some(reserved::escaped(config, arg_ident).as_str()),
                                    false,
                                    false,
                                    config,
                                );
                            }
                        }

                        match layout {
                            Layout::Vertical => write_vertical(out, config, args),
                            Layout::Horizontal => write_horizontal(out, config, args),
                            Layout::Auto => {
                                if !out.try_write(
                                    |out| write_horizontal(out, config, args),
                                    config.line_length,
                                ) {
                                    write_vertical(out, config, args)
                                }
                            }
                        }

                        out.write(")");

                        if ident.is_none() {
                            out.write(": ");
                        }

                        if never_return {
                            if let Some(ref no_return_attr) = config.function.no_return {
                                out.write_fmt(format_args!(" {no_return_attr}"));
                            }
                        }
                    }
                }
            }
        }

        if ident.is_some() {
            out.write(": ");
        }

        // Write the left part of declarators before the identifier
        let mut iter_rev = self.declarators.iter().rev().peekable();

        #[allow(clippy::while_let_on_iterator)]
        while let Some(declarator) = iter_rev.next() {
            let _next_is_pointer = iter_rev.peek().is_some_and(|x| x.is_ptr());

            match *declarator {
                NDeclarator::Ptr { .. } => {
                    out.write("ptr ");
                }
                NDeclarator::Array(..) => {}
                NDeclarator::Func { .. } => {}
            }
        }

        // Write the right part of declarators after the identifier
        let mut iter = self.declarators.iter();
        let mut _last_was_pointer = false;

        #[allow(clippy::while_let_on_iterator)]
        while let Some(declarator) = iter.next() {
            match *declarator {
                NDeclarator::Ptr { .. } => {
                    _last_was_pointer = true;
                }
                NDeclarator::Array(ref _constant) => {}
                NDeclarator::Func { never_return, .. } => {
                    if never_return {
                        if let Some(ref no_return_attr) = config.function.no_return {
                            out.write_fmt(format_args!(" {no_return_attr}"));
                        }
                    }
                }
            }
        }

        write!(out, "{}", self.type_name);

        while close_return > 0 {
            out.write(")");
            close_return -= 1;
        }
    }
}

fn nim_write_func<F: Write>(
    out: &mut SourceWriter<F>,
    f: &Function,
    layout: Layout,
    config: &Config,
) {
    NCdecl::from_func(f, layout, config).write(out, Some(f.path().name()), true, true, config);
}

fn nim_write_field<F: Write>(out: &mut SourceWriter<F>, t: &Type, ident: &str, config: &Config) {
    NCdecl::from_type(t, config).write(out, Some(&nim_ident(ident)), true, false, config);
}

fn nim_write_type<F: Write>(out: &mut SourceWriter<F>, t: &Type, config: &Config) {
    NCdecl::from_type(t, config).write(out, None, true, false, config);
}

/// Map a C binary operator to its Nim equivalent.
fn nim_binop(op: &str) -> &str {
    match op {
        "<<" => "shl",
        ">>" => "shr",
        "&&" => "and",
        "||" => "or",
        other => other,
    }
}

/// Nim does not allow consecutive underscores or a trailing underscore in
/// identifiers, but the shared mangling can produce them (e.g. `Foo_i32__i32`
/// for `Foo<i32, i32>`). Collapse them so the result is a valid Nim identifier.
fn nim_ident(s: &str) -> Cow<'_, str> {
    if !s.contains("__") && !s.ends_with('_') {
        return Cow::Borrowed(s);
    }
    let mut result = String::with_capacity(s.len());
    let mut prev_underscore = false;
    for c in s.chars() {
        if c == '_' && prev_underscore {
            continue;
        }
        result.push(c);
        prev_underscore = c == '_';
    }
    let result = result.trim_end_matches('_');
    if result.is_empty() {
        Cow::Borrowed(s)
    } else {
        Cow::Owned(result.to_string())
    }
}

/// Strip trailing C integer suffixes (`ull`, `ul`, `ll`, `l`, `u`, ...) from a
/// literal so that it is a valid Nim integer literal.
fn strip_c_int_suffix(v: &str) -> Cow<'_, str> {
    let trimmed = v.trim();
    // Only touch things that look like a (possibly signed) integer literal.
    let body = trimmed.strip_prefix('-').unwrap_or(trimmed);
    let bytes = body.as_bytes();
    if bytes.is_empty() || !bytes[0].is_ascii_digit() {
        return Cow::Borrowed(v);
    }
    // Walk back over trailing u/l suffix characters.
    let mut end = body.len();
    while end > 1 && matches!(bytes[end - 1], b'u' | b'U' | b'l' | b'L') {
        end -= 1;
    }
    if end == body.len() {
        Cow::Borrowed(v)
    } else {
        let digits = &body[..end];
        if digits.is_empty() || !digits.bytes().all(|b| b.is_ascii_digit()) {
            return Cow::Borrowed(v);
        }
        Cow::Owned(format!(
            "{}{}",
            if trimmed.starts_with('-') { "-" } else { "" },
            digits
        ))
    }
}

pub struct NimLanguageBackend<'a> {
    config: &'a Config,
}

impl<'a> NimLanguageBackend<'a> {
    pub fn new(config: &'a Config) -> Self {
        Self { config }
    }

    fn write_field<W: Write>(&mut self, out: &mut SourceWriter<W>, f: &Field) {
        let condition = f.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &f.documentation);
        nim_write_field(out, &f.ty, &f.name, self.config);

        condition.write_after(self.config, out);
        if condition.is_some() {
            out.new_line();
        }
    }

    fn write_variant<W: Write>(&mut self, out: &mut SourceWriter<W>, u: &EnumVariant) {
        let condition = u.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &u.documentation);
        write!(out, "{}", nim_ident(&u.export_name));

        condition.write_after(self.config, out);
    }

    /// Emit the tag enum and everything related to it.
    fn write_tag_enum<W: Write>(
        &mut self,
        out: &mut SourceWriter<W>,
        e: &Enum,
        size: Option<&str>,
        has_data: bool,
        tag_name: &str,
    ) {
        let tag_name = &*nim_ident(tag_name);
        if let Some(prim) = size {
            write!(
                out,
                "type {}* {{.size: sizeof({}).}} = enum",
                tag_name, prim
            );
        } else {
            write!(out, "type {}* = enum", tag_name);
        }
        out.new_line();
        out.open_brace();

        for (i, variant) in e.variants.iter().enumerate() {
            if i != 0 {
                out.new_line()
            }
            self.write_variant(out, variant);
        }

        out.close_brace(true);
        let _ = has_data;
    }

    /// The code here mirrors the beginning of `write_struct` and `write_union`.
    fn open_struct_or_union<W: Write>(&mut self, out: &mut SourceWriter<W>, e: &Enum) {
        write!(out, "type {}* = object", nim_ident(e.export_name()));
        out.new_line();
        out.open_brace();
    }

    /// Emit struct definitions for variants having data.
    fn write_variant_defs<W: Write>(&mut self, out: &mut SourceWriter<W>, e: &Enum) {
        for variant in &e.variants {
            if let VariantBody::Body {
                ref body,
                inline: false,
                ..
            } = variant.body
            {
                out.new_line();
                out.new_line();
                let condition = variant.cfg.to_condition(self.config);
                condition.write_before(self.config, out);
                self.write_struct(out, body);
                condition.write_after(self.config, out);
            }
        }
    }

    /// Emit tag field that is separate from all variants.
    fn write_tag_field<W: Write>(
        &mut self,
        out: &mut SourceWriter<W>,
        inline_tag_field: bool,
        tag_name: &str,
    ) {
        let wrap_tag = inline_tag_field && false;

        if wrap_tag {
            out.write("struct");
            out.open_brace();
        }

        write!(out, "case tag*: {}", tag_name);
        out.new_line();

        if wrap_tag {
            out.close_brace(true);
        }
    }

    /// Emit fields for all variants with data.
    fn write_variant_fields<W: Write>(&mut self, out: &mut SourceWriter<W>, e: &Enum) {
        let mut first = true;
        let mut has_else = false;
        for variant in &e.variants {
            if let VariantBody::Body {
                name, body, inline, ..
            } = &variant.body
            {
                if !first {
                    out.new_line();
                }
                first = false;
                let condition = variant.cfg.to_condition(self.config);
                condition.write_before(self.config, out);
                out.write("of ");
                self.write_variant(out, variant);
                out.write(":");
                out.new_line();
                out.open_brace();
                if *inline {
                    let start_field = 0;
                    out.write_vertical_source_list(
                        self,
                        &body.fields[start_field..],
                        ListType::Cap(""),
                        Self::write_field,
                    );
                } else {
                    write!(
                        out,
                        "{}*: {}",
                        nim_ident(name),
                        nim_ident(body.export_name())
                    );
                }
                out.close_brace(false);

                condition.write_after(self.config, out);
            } else {
                has_else = true;
            }
        }
        if has_else {
            if !first {
                out.new_line();
            }
            out.write("else: discard")
        }
    }
}

impl LanguageBackend for NimLanguageBackend<'_> {
    fn open_namespaces<W: Write>(&mut self, _out: &mut SourceWriter<W>) {}

    fn close_namespaces<W: Write>(&mut self, _out: &mut SourceWriter<W>) {}

    fn write_headers<W: Write>(&self, out: &mut SourceWriter<W>, _package_version: &str) {
        // The `header` is C/C++ preprocessor code and is meaningless in Nim,
        // so it is not emitted for the Nim backend.
        if self.config.include_version {
            out.new_line_if_not_start();
            write!(
                out,
                "# Generated with nbindgen:{}",
                crate::bindgen::config::VERSION
            );
            out.new_line();
        }
        if let Some(ref f) = self.config.autogen_warning {
            out.new_line_if_not_start();
            write!(out, "{f}");
            out.new_line();
        }

        if self.config.no_includes
            && self.config.imports.is_empty()
            && self.config.includes.is_empty()
        {
            return;
        }

        out.new_line_if_not_start();

        for import in &self.config.imports {
            write!(out, "import {import}");
            out.new_line();
        }

        for include in &self.config.includes {
            write!(out, "include {include}");
            out.new_line();
        }
    }

    fn write_footers<W: Write>(&mut self, _out: &mut SourceWriter<W>) {}

    // The `trailer` is C/C++ preprocessor code and is meaningless in Nim.
    fn write_trailer<W: Write>(&mut self, _out: &mut SourceWriter<W>, _b: &Bindings) {}

    fn write_enum<W: Write>(&mut self, out: &mut SourceWriter<W>, e: &Enum) {
        let size = e
            .repr
            .ty
            .map(|ty| ty.to_primitive().to_repr_nim(self.config));
        let has_data = e.tag.is_some();
        let inline_tag_field = e.repr.style != crate::bindgen::ir::ReprStyle::C;
        let tag_name = &*nim_ident(e.tag.as_deref().unwrap_or_else(|| e.export_name()));

        let condition = e.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &e.documentation);

        // Emit the tag enum and everything related to it.
        self.write_tag_enum(out, e, size, has_data, tag_name);

        // If the enum has data, we need to emit structs for the variants and
        // gather them together.
        if has_data {
            self.write_variant_defs(out, e);
            out.new_line();
            out.new_line();

            self.open_struct_or_union(out, e);

            // Emit tag field that is separate from all variants.
            self.write_tag_field(out, inline_tag_field, tag_name);
            out.new_line();

            // Emit fields for all variants with data.
            self.write_variant_fields(out, e);

            out.close_brace(true);
        }

        condition.write_after(self.config, out);
    }

    fn write_struct<W: Write>(&mut self, out: &mut SourceWriter<W>, s: &Struct) {
        if s.is_transparent {
            let typedef = Typedef {
                path: s.path.clone(),
                export_name: s.export_name.to_owned(),
                generic_params: s.generic_params.clone(),
                aliased: s.fields[0].ty.clone(),
                cfg: s.cfg.clone(),
                annotations: s.annotations.clone(),
                documentation: s.documentation.clone(),
            };
            self.write_type_def(out, &typedef);
            for constant in &s.associated_constants {
                out.new_line();
                constant.write(self.config, self, out, Some(s));
            }
            return;
        }

        let condition = s.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &s.documentation);

        out.write("type");

        if s.annotations.must_use(self.config) {
            if let Some(ref anno) = self.config.structure.must_use {
                write!(out, " {anno}");
            }
        }
        if let Some(note) = s
            .annotations
            .deprecated_note(self.config, DeprecatedNoteKind::Struct)
        {
            write!(out, " {note}");
        }

        write!(out, " {}*", nim_ident(s.export_name()));

        out.write(" = object");
        out.new_line();
        out.open_brace();

        out.write_vertical_source_list(self, &s.fields, ListType::Cap(""), Self::write_field);

        out.close_brace(true);

        condition.write_after(self.config, out);
    }

    fn write_union<W: Write>(&mut self, out: &mut SourceWriter<W>, u: &Union) {
        let condition = u.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &u.documentation);

        write!(out, "type {}* {{.union.}}", nim_ident(u.export_name()));

        out.write(" = object");
        out.new_line();
        out.open_brace();

        out.write_vertical_source_list(self, &u.fields, ListType::Cap(""), Self::write_field);

        out.close_brace(true);

        condition.write_after(self.config, out);
    }

    fn write_opaque_item<W: Write>(&mut self, out: &mut SourceWriter<W>, o: &OpaqueItem) {
        let condition = o.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &o.documentation);

        write!(out, "type {}*", nim_ident(o.export_name()));

        out.write(" {.incompleteStruct.} = object");

        condition.write_after(self.config, out);
    }

    fn write_type_def<W: Write>(&mut self, out: &mut SourceWriter<W>, t: &Typedef) {
        let condition = t.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &t.documentation);

        write!(out, "type {}*", nim_ident(t.export_name()));

        out.write(" = ");
        self.write_type(out, &t.aliased);

        condition.write_after(self.config, out);
    }

    fn write_static<W: Write>(&mut self, out: &mut SourceWriter<W>, s: &Static) {
        let condition = s.cfg.to_condition(self.config);
        condition.write_before(self.config, out);

        self.write_documentation(out, &s.documentation);

        out.write("var ");
        nim_write_field(out, &s.ty, &s.export_name, self.config);

        condition.write_after(self.config, out);
    }

    fn write_function_with_layout<W: Write>(
        &mut self,
        config: &Config,
        out: &mut SourceWriter<W>,
        func: &Function,
        layout: Layout,
    ) {
        let prefix = config.function.prefix(&func.annotations);
        let postfix = config.function.postfix(&func.annotations);

        let condition = func.cfg.to_condition(config);
        condition.write_before(config, out);

        self.write_documentation(out, &func.documentation);

        if func.extern_decl {
            out.write("extern ");
        } else {
            if let Some(ref prefix) = prefix {
                write!(out, "{prefix} ");
            }
            if func.annotations.must_use(config) {
                if let Some(ref anno) = config.function.must_use {
                    write!(out, "{anno} ");
                }
            }
            if let Some(note) = func
                .annotations
                .deprecated_note(config, DeprecatedNoteKind::Function)
            {
                write!(out, "{note} ");
            }
        }

        nim_write_func(out, func, layout, config);

        if !func.extern_decl {
            if let Some(ref postfix) = postfix {
                write!(out, " {postfix}");
            }
        }

        if let Some(ref swift_name_macro) = config.function.swift_name_macro {
            if let Some(swift_name) = func.swift_name(config) {
                write!(out, " {swift_name_macro}({swift_name})");
            }
        }

        write!(out, " {{.importc: \"{}\".}}", func.path().name());

        condition.write_after(config, out);
    }

    fn write_type<W: Write>(&mut self, out: &mut SourceWriter<W>, t: &Type) {
        nim_write_type(out, t, self.config);
    }

    fn write_documentation<W: Write>(&mut self, out: &mut SourceWriter<W>, d: &Documentation) {
        if d.doc_comment.is_empty() || !self.config.documentation {
            return;
        }

        let end = match self.config.documentation_length {
            DocumentationLength::Short => 1,
            DocumentationLength::Full => d.doc_comment.len(),
        };

        let style = match self.config.documentation_style {
            DocumentationStyle::Auto => DocumentationStyle::C,
            other => other,
        };

        match style {
            DocumentationStyle::C => {
                out.write("#");
            }
            DocumentationStyle::Doxy => {
                out.write("##");
            }
            _ => (),
        }

        for line in &d.doc_comment[..end] {
            match style {
                DocumentationStyle::C => out.write("#"),
                DocumentationStyle::Doxy => out.write("# *"),
                DocumentationStyle::C99 => out.write("#"),
                DocumentationStyle::Cxx => out.write("##"),
                DocumentationStyle::Auto => unreachable!(),
            }

            write!(out, "{line}");
            out.new_line();
        }
    }

    fn write_literal<W: Write>(&mut self, out: &mut SourceWriter<W>, l: &Literal) {
        match l {
            Literal::Expr(v) => write!(out, "{}", strip_c_int_suffix(v.as_str())),
            Literal::Array { items } => {
                write!(out, "@[");
                for (i, item) in items.iter().enumerate() {
                    if i != 0 {
                        write!(out, ", ");
                    }
                    self.write_literal(out, item);
                }
                write!(out, "]");
            }
            Literal::Path {
                ref associated_to,
                ref name,
            } => {
                if let Some((ref path, ref export_name)) = associated_to {
                    if let Some(known) = to_known_assoc_constant(path, name) {
                        return write!(out, "{known}");
                    }
                    if let Some(variant) = out.bindings().enum_variant_reference(path, name) {
                        return write!(out, "{variant}");
                    }
                    write!(out, "{}_", nim_ident(export_name));
                }
                write!(out, "{name}");
            }
            Literal::FieldAccess {
                ref base,
                ref field,
            } => {
                write!(out, "(");
                self.write_literal(out, base);
                write!(out, ").{field}");
            }
            Literal::PostfixUnaryOp { op, ref value } => {
                write!(out, "{op}");
                self.write_literal(out, value);
            }
            Literal::BinOp {
                ref left,
                op,
                ref right,
            } => {
                write!(out, "(");
                self.write_literal(out, left);
                write!(out, " {} ", nim_binop(op));
                self.write_literal(out, right);
                write!(out, ")");
            }
            Literal::Cast { ref ty, ref value } => {
                out.write("cast[");
                self.write_type(out, ty);
                out.write("](");
                self.write_literal(out, value);
                out.write(")");
            }
            Literal::Struct {
                export_name,
                fields,
                path,
            } => {
                write!(out, "{}(", nim_ident(export_name));

                let mut is_first_field = true;
                let ordered_fields = out.bindings().struct_field_names(path);
                for ordered_key in ordered_fields.iter() {
                    if let Some(lit) = fields.get(ordered_key) {
                        if !is_first_field {
                            write!(out, ", ");
                        } else {
                            is_first_field = false;
                        }
                        write!(out, "{ordered_key}: ");

                        self.write_literal(out, &lit.value);
                    }
                }
                write!(out, ")");
            }
        }
    }
}
