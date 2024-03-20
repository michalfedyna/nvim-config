return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	init = function()
		require("todo-comments").setup({
      signs = false,
    })
	end,
}
