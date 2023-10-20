/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

use std::borrow::Cow;
use std::cell::RefCell;
use std::collections::HashMap;
use std::fs;
use std::fs::File;
use std::io::{Read, Write};
use std::path;
use std::rc::Rc;

use crate::bindgen::config::Config;
use crate::bindgen::ir::{
    Constant, Function, ItemContainer, ItemMap, Path as BindgenPath, Static, Struct, Typedef,
};
use crate::bindgen::writer::{Source, SourceWriter};

/// A bindings header that can be written.
pub struct Bindings {
    pub config: Config,
    /// The map from path to struct, used to lookup whether a given type is a
    /// transparent struct. This is needed to generate code for constants.
    struct_map: ItemMap<Struct>,
    typedef_map: ItemMap<Typedef>,
    struct_fileds_memo: RefCell<HashMap<BindgenPath, Rc<Vec<String>>>>,
    globals: Vec<Static>,
    constants: Vec<Constant>,
    items: Vec<ItemContainer>,
    functions: Vec<Function>,
    source_files: Vec<path::PathBuf>,
    /// Bindings are generated by a recursive call to cbindgen
    /// and shouldn't do anything when written anywhere.
    noop: bool,
}

impl Bindings {
    #[allow(clippy::too_many_arguments)]
    pub(crate) fn new(
        config: Config,
        struct_map: ItemMap<Struct>,
        typedef_map: ItemMap<Typedef>,
        constants: Vec<Constant>,
        globals: Vec<Static>,
        items: Vec<ItemContainer>,
        functions: Vec<Function>,
        source_files: Vec<path::PathBuf>,
        noop: bool,
    ) -> Bindings {
        Bindings {
            config,
            struct_map,
            typedef_map,
            struct_fileds_memo: Default::default(),
            globals,
            constants,
            items,
            functions,
            source_files,
            noop,
        }
    }

    // FIXME(emilio): What to do when the configuration doesn't match?
    pub fn struct_is_transparent(&self, path: &BindgenPath) -> bool {
        let mut any = false;
        self.struct_map.for_items(path, |s| any |= s.is_transparent);
        any
    }

    /// Peels through typedefs to allow resolving structs.
    fn resolved_struct_path<'a>(&self, path: &'a BindgenPath) -> Cow<'a, BindgenPath> {
        use crate::bindgen::ir::Type;

        let mut resolved_path = Cow::Borrowed(path);
        loop {
            let mut found = None;
            self.typedef_map.for_items(&resolved_path, |item| {
                if let Type::Path(ref p) = item.aliased {
                    found = Some(p.path().clone());
                }
            });
            resolved_path = match found {
                Some(p) => Cow::Owned(p),
                None => break,
            }
        }
        resolved_path
    }

    pub fn struct_exists(&self, path: &BindgenPath) -> bool {
        let mut any = false;
        self.struct_map
            .for_items(&self.resolved_struct_path(path), |_| any = true);
        any
    }

    pub fn struct_field_names(&self, path: &BindgenPath) -> Rc<Vec<String>> {
        let mut memos = self.struct_fileds_memo.borrow_mut();
        if let Some(memo) = memos.get(path) {
            return memo.clone();
        }

        let resolved_path = self.resolved_struct_path(path);

        let mut fields = Vec::<String>::new();
        self.struct_map.for_items(&resolved_path, |st| {
            let mut pos: usize = 0;
            for field in &st.fields {
                if let Some(found_pos) = fields.iter().position(|v| *v == field.name) {
                    pos = found_pos + 1;
                } else {
                    fields.insert(pos, field.name.clone());
                    pos += 1;
                }
            }
        });

        let fields = Rc::new(fields);
        memos.insert(path.clone(), fields.clone());
        if let Cow::Owned(p) = resolved_path {
            memos.insert(p, fields.clone());
        }
        fields
    }

    pub fn generate_depfile<P: AsRef<path::Path>>(&self, header_path: P, depfile_path: P) {
        if let Some(dir) = depfile_path.as_ref().parent() {
            if !dir.exists() {
                std::fs::create_dir_all(dir).unwrap()
            }
        }
        let canon_header_path = header_path.as_ref().canonicalize().unwrap();
        let mut canon_source_files: Vec<_> = self
            .source_files
            .iter()
            .chain(self.config.config_path.as_ref())
            .map(|p| p.canonicalize().unwrap())
            .collect();
        // Sorting makes testing easier by ensuring the output is ordered.
        canon_source_files.sort_unstable();

        // When writing the depfile we must escape whitespace in paths to avoid it being interpreted
        // as a seperator.
        // It is not clear how to otherwise _correctly_ replace whitespace in a non-unicode
        // compliant slice, without knowing the encoding, so we lossy convert such cases,
        // to avoid panics.
        let mut depfile = File::create(depfile_path).unwrap();
        write!(
            &mut depfile,
            "{}:",
            canon_header_path.to_string_lossy().replace(' ', "\\ ")
        )
        .expect("Writing header name to depfile failed");
        canon_source_files.into_iter().for_each(|source_file| {
            // Add line-continue and line-break and then indent with 4 spaces.
            // This makes the output more human-readable.
            depfile.write_all(b" \\\n    ").unwrap();
            let escaped_path = source_file.to_string_lossy().replace(' ', "\\ ");
            depfile.write_all(escaped_path.as_bytes()).unwrap();
        });

        writeln!(&mut depfile).unwrap();

        depfile.flush().unwrap();
    }

    pub fn write_to_file<P: AsRef<path::Path>>(&self, path: P) -> bool {
        if self.noop {
            return false;
        }

        // Don't compare files if we've never written this file before
        if !path.as_ref().is_file() {
            if let Some(parent) = path::Path::new(path.as_ref()).parent() {
                fs::create_dir_all(parent).unwrap();
            }
            self.write(File::create(path).unwrap());
            return true;
        }

        let mut new_file_contents = Vec::new();
        self.write(&mut new_file_contents);

        let mut old_file_contents = Vec::new();
        {
            let mut old_file = File::open(&path).unwrap();
            old_file.read_to_end(&mut old_file_contents).unwrap();
        }

        if old_file_contents != new_file_contents {
            let mut new_file = File::create(&path).unwrap();
            new_file.write_all(&new_file_contents).unwrap();
            true
        } else {
            false
        }
    }

    pub fn write_headers<F: Write>(&self, out: &mut SourceWriter<F>) {
        if self.noop {
            return;
        }

        if let Some(ref f) = self.config.header {
            out.new_line_if_not_start();
            write!(out, "{}", f);
            out.new_line();
        }
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
            write!(out, "{}", f);
            out.new_line();
        }

        if self.config.no_includes
            && self.config.imports.is_empty()
            && self.config.includes.is_empty()
        {
            return;
        }

        out.new_line_if_not_start();

        if !self.config.no_includes {
            // TODO: standard imports needed?
        }

        for import in &self.config.imports {
            write!(out, "import {}", import);
            out.new_line();
        }

        for include in &self.config.includes {
            write!(out, "include {}", include);
            out.new_line();
        }
    }

    pub fn write<F: Write>(&self, file: F) {
        if self.noop {
            return;
        }

        let mut out = SourceWriter::new(file, self);

        self.write_headers(&mut out);

        for constant in &self.constants {
            if constant.uses_only_primitive_types() {
                out.new_line_if_not_start();
                constant.write(&self.config, &mut out, None);
                out.new_line();
            }
        }

        if self.items.len() > 0 {
            out.new_line_if_not_start();

            for item in &self.items {
                if item
                    .deref()
                    .annotations()
                    .bool("no-export")
                    .unwrap_or(false)
                {
                    continue;
                }

                out.new_line();
                match *item {
                    ItemContainer::Constant(..) => unreachable!(),
                    ItemContainer::Static(..) => unreachable!(),
                    ItemContainer::Enum(ref x) => x.write(&self.config, &mut out),
                    ItemContainer::Struct(ref x) => x.write(&self.config, &mut out),
                    ItemContainer::Union(ref x) => x.write(&self.config, &mut out),
                    ItemContainer::OpaqueItem(ref x) => x.write(&self.config, &mut out),
                    ItemContainer::Typedef(ref x) => x.write(&self.config, &mut out),
                }
                out.new_line();
            }
        }

        for constant in &self.constants {
            if !constant.uses_only_primitive_types() {
                out.new_line_if_not_start();
                constant.write(&self.config, &mut out, None);
                out.new_line();
            }
        }

        if !self.functions.is_empty() || !self.globals.is_empty() {
            for global in &self.globals {
                out.new_line_if_not_start();
                global.write(&self.config, &mut out);
                out.new_line();
            }

            for function in &self.functions {
                out.new_line_if_not_start();
                function.write(&self.config, &mut out);
                out.new_line();
            }
        }

        if let Some(ref f) = self.config.trailer {
            out.new_line_if_not_start();
            write!(out, "{}", f);
            if !f.ends_with('\n') {
                out.new_line();
            }
        }
    }
}
