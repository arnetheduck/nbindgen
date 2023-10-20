# `nbindgen` &emsp; [![Build Status]][actions] [![Latest Version]][crates.io] [![Api Rustdoc]][rustdoc] [![Rust](https://img.shields.io/badge/rust-1.64%2B-blue.svg?maxAge=3600)](https://github.com/arnetheduck/nbindgen)

[Build Status]: https://github.com/arnetheduck/nbindgen/workflows/cbindgen/badge.svg
[actions]: https://github.com/arnetheduck/nbindgen/actions
[Latest Version]: https://img.shields.io/crates/v/nbindgen.svg
[crates.io]: https://crates.io/crates/nbindgen
[Api Rustdoc]: https://img.shields.io/badge/api-rustdoc-blue.svg
[rustdoc]: https://docs.rs/nbindgen

[Read the full user docs here!](docs.md)

nbindgen creates Nim headers for Rust libraries which expose a public C-like API - if your library works with `cbindgen` it will likely work with `nbindgen` also.

It is based on / a fork of [cbindgen](https://github.com/mozilla/cbindgen) - in
fact, most of the code is the same and lots of it hasn't been updated for Nim
yet and you'll find many out-of-date references to `cbindgen` and `C` stuff that
needs updating.

While you could do this by hand, it's not a particularly good use of your time.
It's also much more likely to be error-prone than machine-generated headers that
are based on your actual Rust code. The cbindgen developers have also worked
closely with the developers of Rust to ensure that the headers we generate
reflect actual guarantees about Rust's type layout and ABI.

There are two ways to use nbindgen: as a standalone program, or as a library
(presumably in your build.rs). There isn't really much practical difference,
because cbindgen is a simple rust library with no interesting dependencies.

Using it as a program means people building your software will need it
installed. Using it in your library means people may have to build cbindgen more
frequently (e.g. every time they update their rust compiler).

It's worth noting that the development of cbindgen and nbindgen has been largely adhoc, as
features have been added to support the usecases of the maintainers. This means
cbindgen may randomly fail to support some particular situation simply because
no one has put in the effort to handle it yet. [Please file an issue if you run
into such a situation](https://github.com/arnetheduck/nbindgen/issues/new). Although
since we all have other jobs, you might need to do the implementation work too
:)

# Quick Start

To install nbindgen, you just need to run

```text
cargo install --force nbindgen
```

(--force just makes it update to the latest nbindgen if it's already installed)

To use nbindgen you need two things:

* A configuration (nbindgen.toml, which can be empty to start)
* A Rust crate with a public C API

Then all you need to do is run it:

```text
nbindgen --config nbindgen.toml --crate my_rust_library --output my_header.h
```

See `nbindgen --help` for more options.

[Read the full user docs here!](docs.md)

[Get a template nbindgen.toml here.](template.toml)

# Examples

We don't currently have a nice tailored example application, but [the
tests](tests/rust/) contain plenty of interesting examples of our features.

You may also find it interesting to browse the projects that are using nbindgen in production:

* who will be first?

If you're using `nbindgen` and would like to be added to this list, please open a pull request!

# Future direction

The rust compiler generates `llvm` ir - so does [nlvm](https://github.com/arnetheduck/nlvm). It would be much better to fuse the two and use the llvm IR directly in a unified build. Until then, this is not a bad option :)
