return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "jfpedroza/neotest-elixir",
    "rcasia/neotest-java",
    "codymikol/neotest-kotlin",
    "mrcjkb/rustaceanvim",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
        require("neotest-java")({}),
        require("neotest-kotlin"),
        require("rustaceanvim.neotest"),
      },
    })
  end,
}
