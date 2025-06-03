return {
  "frankroeder/parrot.nvim",
  dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  config = function()
    require("parrot").setup({
      params = {
        chat = { max_tokens = 1000000 },
        command = { max_tokens = 1000000 },
      },
      providers = {
        gemini = {
          api_key = os.getenv "GEMINI_API_KEY",
        },
      }
    })
  end,
}
