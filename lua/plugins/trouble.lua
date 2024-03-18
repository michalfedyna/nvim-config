return {
	"folke/trouble.nvim",
	lazy = false,
	init = function()
		require("trouble").setup({
			signs = {
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			use_diagnostic_signs = false,
		})
	end,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
