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
	keys = {
		{ "<leader>Xx", "<cmd>XcodebuildPicker<cr>", desc = "Xcode: Actions" },
		{ "<leader>Xs", "<cmd>XcodebuildSetup<cr>", desc = "Xcode: Setup Project" },
		{ "<leader>Xb", "<cmd>XcodebuildBuild<cr>", desc = "Xcode: Build" },
		{ "<leader>Xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Xcode: Build and Run" },
		{ "<leader>Xd", "<cmd>XcodebuildBuildDebug<cr>", desc = "Xcode: Build and Debug" },
		{ "<leader>XD", "<cmd>XcodebuildDebug<cr>", desc = "Xcode: Debug Without Build" },
		{ "<leader>Xt", "<cmd>XcodebuildTest<cr>", desc = "Xcode: Run Tests" },
		{ "<leader>Xt", "<cmd>XcodebuildTestSelected<cr>", mode = "v", desc = "Xcode: Run Selected Tests" },
		{ "<leader>Xn", "<cmd>XcodebuildTestNearest<cr>", desc = "Xcode: Run Nearest Test" },
		{ "<leader>XT", "<cmd>XcodebuildTestClass<cr>", desc = "Xcode: Run Test Class" },
		{ "<leader>X.", "<cmd>XcodebuildTestRepeat<cr>", desc = "Xcode: Repeat Tests" },
		{ "<leader>Xe", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Xcode: Test Explorer" },
		{ "<leader>Xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Xcode: Logs" },
		{ "<leader>Xv", "<cmd>XcodebuildSelectDevice<cr>", desc = "Xcode: Select Device" },
		{ "<leader>XS", "<cmd>XcodebuildSelectScheme<cr>", desc = "Xcode: Select Scheme" },
		{ "<leader>Xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Xcode: Toggle Coverage" },
		{ "<leader>XC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", desc = "Xcode: Coverage Report" },
		{ "<leader>Xk", "<cmd>XcodebuildCancel<cr>", desc = "Xcode: Cancel" },
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("xcodebuild").setup({
			project_config = {
				search_in_parent_dirs = true,
				reload_on_cwd_change = true,
			},
			code_coverage = {
				enabled = true,
				file_pattern = "*.[sm]*",
			},
			integrations = {
				nvim_tree = { enabled = false },
				neo_tree = { enabled = false },
				oil_nvim = { enabled = false },
				snacks_nvim = { enabled = false },
				fzf_lua = { enabled = false },
			},
		})

		require("xcodebuild.integrations.dap").setup()
	end,
}
