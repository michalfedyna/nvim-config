return {
  "folke/which-key.nvim",
  config = function()
    local which_key = require("which-key")

    which_key.setup({
      icons = {
        breadcrumb = "-",
        separator = "=",
        group = "+",
      },
    })

    which_key.add({
      { "gr", group = "LSP", mode = { "n", "v" } },
      { "<leader>s", group = "Search", mode = { "n", "v" } },
      { "<leader>t", group = "Toggles" },
      { "<leader>m", group = "Macros" },
    })
  end,
}
