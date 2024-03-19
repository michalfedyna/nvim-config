return {
	"nvimdev/lspsaga.nvim",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		require("lspsaga").setup({
			lightbulb = {
				sign = false,
			},
			outline = {
				layout = "float",
			},
		})
	end,
}
