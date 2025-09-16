return {
	"catppuccin/nvim",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			float = {
				transparent = true,
				solid = false,
			},
			integrations = {
				cmp = true,
				treesitter = true,
				telescope = {
					enabled = true,
				},
			},
			custom_highlights = function(colors)
				return {
					FloatBorder = { bg = colors.base },
					NormalFloat = { bg = colors.base },
					ZenBg = { bg = colors.base },
					RenderMarkdownCode = { bg = colors.base },
					RenderMarkdownCodeInline = { bg = colors.base },
				}
			end,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
