return {
  "catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      integrations = {
        cmp = true,
        treesitter = true,
        telescope = {
          enabled = true,
        }
      },
      custom_highlights = function(colors)
        return {
          FloatBorder = { bg = colors.base },
          NormalFloat = { bg = colors.base },
          ZenBg = { bg = colors.base },
        }
      end
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
