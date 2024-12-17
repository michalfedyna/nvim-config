local ensure_installed = {
  "astro",
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "elixir",
  "erlang",
  "go",
  "heex",
  "html",
  "lua",
  "vimdoc",
  "luadoc",
  "vim",
  "markdown",
  "dockerfile",
  "typescript",
  "tsx",
  "terraform"
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      disable = { "txt" },
      ensure_installed = ensure_installed,
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
