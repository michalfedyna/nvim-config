return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      float = {
        padding = 8
      },
      view_options = {
        show_hidden = true,
      }
    })
  end
}
