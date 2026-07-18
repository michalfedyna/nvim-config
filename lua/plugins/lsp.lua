local ensure_installed = {
	"clangd",
	"neocmake",
	"html",
	"lua_ls",
	"eslint",
	"elixirls",
	"elp",
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

		local registry = require("mason-registry")
		for _, name in ipairs({ "codelldb", "edb", "js-debug-adapter" }) do
			local found, mason_package = pcall(registry.get_package, name)
			if not found then
				vim.notify("Mason package is unavailable: " .. name, vim.log.levels.WARN)
			elseif not mason_package:is_installed() and not mason_package:is_installing() then
				mason_package:install()
			end
		end

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
