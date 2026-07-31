return {
  "chrisgrieser/nvim-recorder",
  dependencies = "rcarriga/nvim-notify",
  config = function()
    require("recorder").setup({
      slots = { "a", "b", "c", "d", "e" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<leader>ms",
        editMacro = "<leader>me",
        yankMacro = "<leader>my",
        deleteAllMacros = "<leader>md",
        addBreakPoint = "<leader>mb",
      },
    })
  end
}
