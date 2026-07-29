# NeoVim Config

## Swift and Objective-C prerequisites

Swift and Objective-C support uses the toolchain selected by `xcode-select` for
SourceKit-LSP, `swift format`, `clang-format`, and `lldb-dap`. It includes
Treesitter highlighting, completion and navigation, formatting, Xcode and
SwiftPM builds, XCTest and Swift Testing support, coverage, and debugging.

Install Xcode and select it as the active developer directory. Mason installs
`xcode-build-server` and `xcbeautify`; nvim-treesitter installs the Swift and
Objective-C parsers. The following commands should resolve successfully:

```sh
xcode-select -p
xcrun --find sourcekit-lsp
xcrun --find swift-format
xcrun --find clang-format
xcrun --find lldb-dap
```

Open Neovim from an Xcode project or workspace root and run
`:XcodebuildSetup` once. The wizard selects the project, scheme, and device and
generates `buildServer.json`, which gives SourceKit-LSP the exact Xcode build
settings. Swift packages are detected through `Package.swift` without a build
server. Run `:checkhealth xcodebuild` from the project root to diagnose the
toolchain and project configuration.

Common Xcode mappings:

- `<leader>Xs`: configure the project
- `<leader>Xx`: show all Xcode actions
- `<leader>Xb`: build
- `<leader>Xr`: build and run
- `<leader>Xd`: build and debug with Apple's LLDB
- `<leader>Xt`: run all tests; in visual mode, run selected tests
- `<leader>Xn`: run the nearest Swift test
- `<leader>Xe`: toggle the test explorer
- `<leader>Xl`: toggle build and test logs
- `<leader>Xv`: select a simulator or device
- `<leader>XC`: show the coverage report

Project builds and full XCTest runs work for both Swift and Objective-C.
Nearest-test and test-class discovery are Swift-oriented; use `<leader>Xt` for
Objective-C XCTest suites. Physical-device debugging additionally requires the
optional `pymobiledevice3` integration documented in `:h xcodebuild.remote-debugger`.

## Rust prerequisites

Rust support includes Treesitter highlighting, rust-analyzer completion and
navigation, `rustfmt` formatting, CodeLLDB debugging, and Neotest integration.
It requires Neovim 0.12 or newer and a Rust toolchain with Cargo on `PATH`.
Install the formatter and linter with rustup:

```sh
rustup component add rustfmt clippy
```

Mason automatically installs rust-analyzer and CodeLLDB, while
nvim-treesitter installs the Rust parser. Rustaceanvim uses Cargo for tests and
automatically uses `cargo-nextest` when it is available. Use `:RustLsp
runnables` to select a Cargo target or `:RustLsp debuggables` to build and debug
one. The Neotest and DAP mappings listed below also work in Rust projects.

## Java and Kotlin prerequisites

Java and Kotlin support includes Treesitter highlighting, LSP completion and
navigation, formatting, debugging, and Neotest adapters.

- Put a JDK 21 or newer on `PATH` to run Eclipse JDT LS. Projects may target an
  older JDK through their Gradle or Maven configuration.
- Make sure the JDK used to import a project is supported by that project's
  Gradle or Maven wrapper. JDK 21 is a safe default for current JVM projects.
- Use a Gradle or Maven wrapper in each project (`gradlew` or `mvnw`) when
  possible.
- Keep the `tree-sitter` CLI available for parser installation.

Mason automatically installs JDT LS, JetBrains' Kotlin LSP, Java and Kotlin
debug adapters, `google-java-format`, and `ktlint`. The JetBrains Kotlin LSP is
currently alpha software and supports JVM Gradle and Maven projects.

Run `:NeotestJava setup` once to download the JUnit Platform runner used by the
Java test adapter. Kotlin tests are supported through Gradle for Kotest suites.
Before launching a Kotlin debug session, compile the project; the launch
configuration prompts for a main class and defaults to the current file's
top-level `FileNameKt` class. Java launch targets are discovered by JDT LS, and
both languages include an attach configuration for `localhost:5005`.

## BEAM prerequisites

Elixir and Erlang support expects these executables on `PATH`:

- `elixir`, `mix`, and `erl`
- `rebar3`
- `erlfmt`
- `tree-sitter` CLI 0.26.1 or newer

On macOS, install the shared tools with:

```sh
brew install tree-sitter-cli rebar3
mix local.hex --force
mix local.rebar --force
```

Install `erlfmt` with your package manager or build its official escript.
Mason automatically installs ElixirLS, ELP, and the Elixir/Erlang debug
adapters; nvim-treesitter installs the configured parsers.

Erlang debugging uses EDB and requires OTP 29 or newer. Attach targets must be
started with the `+D` emulator flag. Add debug metadata to the test profile of
each debuggable `rebar3` project:

```erlang
{profiles, [
    {test, [
        {erl_opts, [debug_info, beam_debug_info, beam_debug_stack]}
    ]}
]}.
```

## Test mappings

- `<leader>tn`: nearest test
- `<leader>tF`: current file
- `<leader>tA`: all tests
- `<leader>tL`: last test
- `<leader>tO`: test output
- `<leader>tS`: test summary
- `<leader>tW`: watch current file
