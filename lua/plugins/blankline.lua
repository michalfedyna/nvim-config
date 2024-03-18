return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = false,
	init = function()
		require("ibl").setup({
			exclude = {
				filetypes = {
					"dashboard",
				},
			},
		})
	end,
}
