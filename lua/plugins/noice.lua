return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { border = "single" })
				end,
			},
		},
	},
	config = function()
		require("noice").setup({
			presets = {
				bottom_search = true,
				command_palette = true,
				lsp_doc_border = true,
				long_message_to_split = true,
			},
			views = {
				cmdline_input = { border = { style = "single" } },
				cmdline_popup = { border = { style = "single" } },
				cmdline_popupmenu = { border = { style = "single" } },
				confirm = { border = { style = "single" } },
				hover = { border = { style = "single" } },
				popup = { border = { style = "single" } },
			},
		})
	end,
}
