return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
      desc = "Buffer diagnostics",
    },
    {
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "All diagnostics",
    },
    {
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols outline",
    },
    {
      "<leader>tl",
      "<cmd>Trouble lsp toggle focus=false<cr>",
      desc = "LSP results",
    },
    {
      "<leader>tq",
      "<cmd>Trouble qflist toggle focus=true<cr>",
      desc = "Quickfix list",
    },
    {
      "<leader>tL",
      "<cmd>Trouble loclist toggle focus=true<cr>",
      desc = "Location list",
    },
  },
  opts = {
    modes = {
      diagnostics = {
        win = { position = "bottom" },
      },
      symbols = {
        win = { position = "right", size = 60 },
      },
      lsp = {
        win = { position = "right", size = 60 },
      },
    },
    win = {
      wo = {
        wrap = true,
      },
    },
  },
}
