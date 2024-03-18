return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	init = function()
		local tel = require("telescope")
		tel.setup({})
		pcall(tel.load_extension, "fzf")
		tel.load_extension("file_browser")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
}
