return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      win = {
        wo = {
          wrap = true
        }
      }
    })
  end
}
