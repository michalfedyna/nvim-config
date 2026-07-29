return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
        swift = { "swift" },
        lua = { "stylua" },
        javascript = { "prettier" },
        ["javascript.jsx"] = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        ["typescript.jsx"] = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        astro = { "prettier" },
        java = { "google-java-format" },
        kotlin = { "ktlint" },
        rust = { "rustfmt" },
        elixir = { "mix" },
        heex = { "mix" },
        erlang = { "erlfmt" },
        sh = { "shfmt" },
        markdown = { "prettier" },
        terraform = { "terraform fmt" },
        yaml = { "prettier" },
        yml = { "prettier" }
      },
      formatters = {
        ["clang-format"] = {
          command = "xcrun",
          prepend_args = { "clang-format" },
        },
      },
    })
  end,
}
