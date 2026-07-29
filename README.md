# NeoVim Config

## Swift and Objective-C prerequisites

Swift and Objective-C support uses the toolchain selected by `xcode-select` for
SourceKit-LSP, `swift format`, and `clang-format`. It includes Treesitter
highlighting, completion and navigation, and formatting.

Install Xcode and select it as the active developer directory. The following
commands should resolve successfully:

```sh
xcode-select -p
xcrun --find sourcekit-lsp
xcrun --find swift-format
xcrun --find clang-format
```

nvim-treesitter installs the Swift and Objective-C parsers. Swift packages are
detected through `Package.swift`; Xcode projects need their normal SourceKit-LSP
build-server configuration for complete project-aware results.

## Rust prerequisites

Rust support includes Treesitter highlighting, rust-analyzer completion and
navigation, and `rustfmt` formatting. It requires a Rust toolchain on `PATH`.
Install the formatter with rustup:

```sh
rustup component add rustfmt
```

Mason automatically installs and enables rust-analyzer, while nvim-treesitter
installs the Rust parser.

## Java and Kotlin prerequisites

Java and Kotlin support includes Treesitter highlighting, LSP completion and
navigation, and formatting.

- Put a JDK 21 or newer on `PATH` to run Eclipse JDT LS. Projects may target an
  older JDK through their Gradle or Maven configuration.
- Make sure the JDK used to import a project is supported by that project's
  Gradle or Maven wrapper. JDK 21 is a safe default for current JVM projects.
- Use a Gradle or Maven wrapper in each project (`gradlew` or `mvnw`) when
  possible.
- Keep the `tree-sitter` CLI available for parser installation.

Mason automatically installs JDT LS, JetBrains' Kotlin LSP,
`google-java-format`, and `ktlint`. The JetBrains Kotlin LSP is currently alpha
software and supports JVM Gradle and Maven projects.

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
Mason automatically installs ElixirLS and ELP; nvim-treesitter installs the
configured parsers.
