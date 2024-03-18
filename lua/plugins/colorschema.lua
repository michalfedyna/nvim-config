return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			integrations = {
				mason = true,
				noice = true,
				lsp_trouble = true,
				which_key = true,
			},
		})

		vim.cmd("colorscheme catppuccin")
	end,
}

--local colorschema = {
--	"folke/tokyonight.nvim",
--	lazy = false,
--	priority = 1000,
--	config = function()
--		vim.cmd("colorscheme tokyonight")
--	end,
--}
