return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        ["javascript.jsx"] = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        ["typescript.jsx"] = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        astro = { "prettier" },
        elixir = { "mix format" },
        heex = { "mix format" },
        sh = { "shfmt" },
        markdown = { "prettier" },
      },
    })
  end,
}
