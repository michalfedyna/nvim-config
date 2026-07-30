return {
	"wojciech-kulik/xcodebuild.nvim",
	ft = { "swift", "objc", "objcpp" },
	cmd = { "XcodebuildSetup", "XcodebuildPicker" },
	init = function()
		vim.filetype.add({
			extension = {
				m = "objc",
				mm = "objcpp",
			},
		})
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("xcodebuild").setup({
			project_config = {
				search_in_parent_dirs = true,
				reload_on_cwd_change = true,
			},
			console_logs = {
				enabled = false,
			},
			code_coverage = {
				enabled = true,
				file_pattern = "*.[sm]*",
			},
			integrations = {
				pymobiledevice = { enabled = false },
				nvim_tree = { enabled = false },
				neo_tree = { enabled = false },
				oil_nvim = { enabled = false },
				snacks_nvim = { enabled = false },
				fzf_lua = { enabled = false },
			},
		})
	end,
}
