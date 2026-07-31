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
				blink_cmp = {
					style = "bordered",
				},
				treesitter = true,
				telescope = {
					enabled = true,
				},
			},
			custom_highlights = function(colors)
				return {
					FloatBorder = { bg = colors.base },
					FloatTitle = { bg = colors.base },
					NormalFloat = { bg = colors.base },
					NormalSB = { bg = colors.base },
					Pmenu = { bg = colors.base },
					PmenuBorder = { bg = colors.base },
					BlinkCmpMenu = { bg = colors.base },
					BlinkCmpMenuBorder = { bg = colors.base },
					NotifyBackground = { bg = colors.base },
					ZenBg = { bg = colors.base },
					RenderMarkdownCode = { bg = colors.base },
					RenderMarkdownCodeInline = { bg = colors.base },
				}
			end,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
