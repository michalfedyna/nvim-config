return {
  "chrisgrieser/nvim-recorder",
  dependencies = "rcarriga/nvim-notify",
  config = function()
    require("recorder").setup({
      slots = { "a", "b", "c", "d", "e" }
    })
  end
}
