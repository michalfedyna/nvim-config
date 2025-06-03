return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('render-markdown').setup({
      file_types = { 'markdown' },
      completions = { lsp = { enabled = true } },
      code = {
        style = "normal",
        sign = false,
        language_name = false,
        border = "none",
      },
    })
  end
}
