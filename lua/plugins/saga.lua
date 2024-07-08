return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      border = "rounded",
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }
}
