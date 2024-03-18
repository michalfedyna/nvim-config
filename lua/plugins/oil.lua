return {
	"stevearc/oil.nvim",
	init = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 12,
			},
			use_default_keymaps = false,
			keymaps = {
				["<C-c>"] = "actions.close",
				["<CR>"] = "actions.select",
				["-"] = "actions.parent",
				["="] = "actions.open_cwd",
				["+"] = "actions.cd",
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
