# NeoVim Config

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
