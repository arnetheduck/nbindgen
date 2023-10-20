extern crate nbindgen;

use nbindgen::*;
use std::collections::HashSet;
use std::fs::File;
use std::io::Read;
use std::path::Path;
use std::process::Command;
use std::{env, fs, str};

// Set automatically by cargo for integration tests
static CBINDGEN_PATH: &str = env!("CARGO_BIN_EXE_nbindgen");


fn run_cbindgen(
    path: &Path,
    output: Option<&Path>,
    generate_depfile: bool,
) -> (Vec<u8>, Option<String>) {
    assert!(
        !(output.is_none() && generate_depfile),
        "generating a depfile requires outputting to a path"
    );
    let program = Path::new(CBINDGEN_PATH);
    let mut command = Command::new(program);
    if let Some(output) = output {
        command.arg("--output").arg(output);
    }
    let cbindgen_depfile = if generate_depfile {
        let depfile = tempfile::NamedTempFile::new().unwrap();
        command.arg("--depfile").arg(depfile.path());
        Some(depfile)
    } else {
        None
    };

    // match language {
    //     Language::Cxx => {}
    //     Language::C => {
    //         command.arg("--lang").arg("c");

    //         if cpp_compat {
    //             command.arg("--cpp-compat");
    //         }
    //     }
    //     Language::Cython => {
    //         command.arg("--lang").arg("cython");
    //     }
    // }

    // if let Some(style) = style {
    //     command.arg("--style").arg(style_str(style));
    // }

    let config = path.with_extension("toml");
    if config.exists() {
        command.arg("--config").arg(config);
    }

    command.arg(path);

    println!("Running: {:?}", command);
    let cbindgen_output = command.output().expect("failed to execute process");

    assert!(
        cbindgen_output.status.success(),
        "cbindgen failed: {:?} with error: {}",
        output,
        str::from_utf8(&cbindgen_output.stderr).unwrap_or_default()
    );

    let bindings = if let Some(output_path) = output {
        let mut bindings = Vec::new();
        // Ignore errors here, we have assertions on the expected output later.
        let _ = File::open(output_path).map(|mut file| {
            let _ = file.read_to_end(&mut bindings);
        });
        bindings
    } else {
        cbindgen_output.stdout
    };

    let depfile_contents = if let Some(mut depfile) = cbindgen_depfile {
        let mut raw = Vec::new();
        depfile.read_to_end(&mut raw).unwrap();
        Some(
            str::from_utf8(raw.as_slice())
                .expect("Invalid encoding encountered in depfile")
                .into(),
        )
    } else {
        None
    };
    (bindings, depfile_contents)
}

fn compile(
    cbindgen_output: &Path,
    _tests_path: &Path,
    tmp_dir: &Path,
    _skip_warning_as_error: bool,
) {
    let cc = "nim";

    let file_name = cbindgen_output
        .file_name()
        .expect("cbindgen output should be a file");
    let mut object = tmp_dir.join(file_name);
    object.set_extension("o");

    let mut command = Command::new(cc);
    command.arg("check").arg(cbindgen_output);

    println!("Running: {:?}", command);
    let out = command.output().expect("failed to compile");
    assert!(out.status.success(), "Output failed to compile: {:?}", out);

    if object.exists() {
        fs::remove_file(object).unwrap();
    }
}

const SKIP_WARNING_AS_ERROR_SUFFIX: &str = ".skip_warning_as_error";

#[allow(clippy::too_many_arguments)]
fn run_compile_test(
    name: &'static str,
    path: &Path,
    tmp_dir: &Path,
    cbindgen_outputs: &mut HashSet<Vec<u8>>,
) {
    let crate_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let tests_path = Path::new(&crate_dir).join("tests");
    let mut generated_file = tests_path.join("expectations");
    fs::create_dir_all(&generated_file).unwrap();

    let style_ext = "";
    let lang_ext = ".nim";

    let skip_warning_as_error = name.rfind(SKIP_WARNING_AS_ERROR_SUFFIX).is_some();

    let source_file =
        format!("{}{}{}", name, style_ext, lang_ext).replace(SKIP_WARNING_AS_ERROR_SUFFIX, "");

    generated_file.push(source_file);

    let (output_file, generate_depfile) = if env::var_os("CBINDGEN_TEST_VERIFY").is_some() {
        (None, false)
    } else {
        (
            Some(generated_file.as_path()),
            // --depfile does not work in combination with expanding yet, so we blacklist expanding tests.
            !(name.contains("expand") || name.contains("bitfield")),
        )
    };

    let (cbindgen_output, depfile_contents) = run_cbindgen(
        path,
        output_file,
        generate_depfile,
    );
    if generate_depfile {
        let depfile = depfile_contents.expect("No depfile generated");
        assert!(!depfile.is_empty());
        let mut rules = depfile.split(':');
        let target = rules.next().expect("No target found");
        assert_eq!(target, generated_file.as_os_str().to_str().unwrap());
        let sources = rules.next().unwrap();
        // All the tests here only have one sourcefile.
        assert!(
            sources.contains(path.to_str().unwrap()),
            "Path: {:?}, Depfile contents: {}",
            path,
            depfile
        );
        assert_eq!(rules.count(), 0, "More than 1 rule in the depfile");
    }

    if cbindgen_outputs.contains(&cbindgen_output) {
        // We already generated an identical file previously.
        if env::var_os("CBINDGEN_TEST_VERIFY").is_some() {
            assert!(!generated_file.exists());
        } else if generated_file.exists() {
            fs::remove_file(&generated_file).unwrap();
        }
    } else {
        if env::var_os("CBINDGEN_TEST_VERIFY").is_some() {
            let prev_cbindgen_output = fs::read(&generated_file).unwrap();
            assert_eq!(cbindgen_output, prev_cbindgen_output);
        } else {
            fs::write(&generated_file, &cbindgen_output).unwrap();
        }

        cbindgen_outputs.insert(cbindgen_output);

        if env::var_os("CBINDGEN_TEST_NO_COMPILE").is_some() {
            return;
        }

        compile(
            &generated_file,
            &tests_path,
            tmp_dir,
            skip_warning_as_error,
        );
    }
}

fn test_file(name: &'static str, filename: &'static str) {
    let test = Path::new(filename);
    let tmp_dir = tempfile::Builder::new()
        .prefix("cbindgen-test-output")
        .tempdir()
        .expect("Creating tmp dir failed");
    let tmp_dir = tmp_dir.path();
    // Run tests in deduplication priority order. C++ compatibility tests are run first,
    // otherwise we would lose the C++ compiler run if they were deduplicated.
    let mut cbindgen_outputs = HashSet::new();
    run_compile_test(name, test, tmp_dir, &mut cbindgen_outputs);
    // for cpp_compat in &[true, false] {
    //     for style in &[Style::Type, Style::Tag, Style::Both] {
    //         run_compile_test(
    //             name,
    //             test,
    //             tmp_dir,
    //             Language::C,
    //             *cpp_compat,
    //             Some(*style),
    //             &mut cbindgen_outputs,
    //         );
    //     }
    // }

    // run_compile_test(
    //     name,
    //     test,
    //     tmp_dir,
    //     Language::Cxx,
    //     /* cpp_compat = */ false,
    //     None,
    //     &mut HashSet::new(),
    // );

    // // `Style::Both` should be identical to `Style::Tag` for Cython.
    // let mut cbindgen_outputs = HashSet::new();
    // for style in &[Style::Type, Style::Tag] {
    //     run_compile_test(
    //         name,
    //         test,
    //         tmp_dir,
    //         Language::Cython,
    //         /* cpp_compat = */ false,
    //         Some(*style),
    //         &mut cbindgen_outputs,
    //     );
    // }
}

macro_rules! test_file {
    ($test_function_name:ident, $name:expr, $file:tt) => {
        #[test]
        fn $test_function_name() {
            test_file($name, $file);
        }
    };
}

// This file is generated by build.rs
include!(concat!(env!("OUT_DIR"), "/tests.rs"));
