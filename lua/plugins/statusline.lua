return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_y = {
          require("recorder").displaySlots
        },
        lualine_z = {
          require("recorder").recordingStatus
        },
      }
    })
  end
}
