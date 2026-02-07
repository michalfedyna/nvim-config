local ensure_installed = {
	"clangd",
	"neocmake",
	"html",
	"lua_ls",
	"eslint",
	"elixirls",
	"terraformls",
	"cssls",
}

return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
		})

		vim.lsp.config("sourcekit", {
			capabilities = {
				textDocument = {
					diagnostic = {
						dynamicRegistration = true,
						relatedDocumentSupport = true,
					},
				},
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
			filetypes = { "swift", "objc", "objcpp" },
		})
	end,
}
