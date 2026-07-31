return {
  "stevearc/aerial.nvim",
  cmd = {
    "AerialClose",
    "AerialInfo",
    "AerialNavToggle",
    "AerialOpen",
    "AerialToggle",
  },
  keys = {
    { "<leader>t", "<cmd>AerialToggle!<cr>", desc = "Symbols outline" },
    { "[s",        "<cmd>AerialPrev<cr>",    desc = "Previous symbol" },
    { "]s",        "<cmd>AerialNext<cr>",    desc = "Next symbol" },
    {
      "<leader><leader>d",
      function()
        require("telescope").extensions.aerial.aerial()
      end,
      desc = "Document symbols",
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    layout = {
      default_direction = "prefer_right",
      width = 40,
      placement = "window",
    },
    show_guides = true,
  },
}
