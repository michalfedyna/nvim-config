local mason_root = vim.fs.joinpath(vim.fn.stdpath("data"), "mason")

local function java_root(path)
	return vim.fs.root(path, { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts" })
		or vim.fs.root(path, { "pom.xml", "build.gradle", "build.gradle.kts", "build.xml" })
		or vim.fs.root(path, { ".git" })
		or vim.fs.dirname(path)
end

local function start_jdtls(event, capabilities)
	local path = vim.api.nvim_buf_get_name(event.buf)
	if path == "" then
		return
	end

	local root_dir = java_root(path)
	local executable = vim.fn.exepath("jdtls")
	if executable == "" then
		vim.notify("jdtls is not installed yet; restart Neovim after Mason finishes", vim.log.levels.WARN)
		return
	end

	local project = vim.fs.basename(root_dir)
	local workspace = vim.fs.joinpath(
		vim.fn.stdpath("cache"),
		"jdtls",
		project .. "-" .. vim.fn.sha256(root_dir):sub(1, 12)
	)
	local cmd = { executable, "-data", workspace }
	local lombok = vim.fs.joinpath(mason_root, "share", "jdtls", "lombok.jar")
	if (vim.uv or vim.loop).fs_stat(lombok) then
		table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok)
	end

	require("jdtls").start_or_attach({
		cmd = cmd,
		root_dir = root_dir,
		capabilities = capabilities,
		init_options = {
			extendedClientCapabilities = require("jdtls.capabilities"),
		},
		settings = {
			java = {
				inlayHints = {
					parameterNames = { enabled = "all" },
				},
			},
		},
	}, nil, { bufnr = event.buf })
end

local ensure_installed = {
	"clangd",
	"neocmake",
	"html",
	"lua_ls",
	"eslint",
	"elixirls",
	"elp",
	"jdtls",
	"kotlin_lsp",
	"rust_analyzer",
	"terraformls",
	"cssls",
}

return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-jdtls",
	},
	config = function()
		require("mason").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		local sourcekit_root_dir = vim.lsp.config.sourcekit.root_dir
		local clangd_root_markers = vim.lsp.config.clangd.root_markers
		local sourcekit_project = require("lspconfig.util").root_pattern(
			"buildServer.json",
			".bsp",
			"*.xcodeproj",
			"*.xcworkspace",
			"Package.swift"
		)

		-- SourceKit-LSP embeds clangd for Apple and SwiftPM projects. Keep the
		-- standalone clangd client for ordinary compilation-database projects.
		vim.lsp.config("clangd", {
			root_dir = function(bufnr, on_dir)
				local path = vim.api.nvim_buf_get_name(bufnr)
				if path ~= "" and sourcekit_project(path) then
					return
				end

				on_dir(path ~= "" and vim.fs.root(path, clangd_root_markers) or nil)
			end,
		})
		vim.lsp.config("kotlin_lsp", {
			root_markers = {
				{ "gradlew", "mvnw", "settings.gradle", "settings.gradle.kts" },
				{ "build.gradle", "build.gradle.kts", "pom.xml", "workspace.json" },
				".git",
			},
			single_file_support = true,
		})
		vim.lsp.config("sourcekit", {
			cmd = { "xcrun", "sourcekit-lsp" },
			filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
			root_dir = function(bufnr, on_dir)
				local path = vim.api.nvim_buf_get_name(bufnr)
				if vim.bo[bufnr].filetype == "swift" or (path ~= "" and sourcekit_project(path)) then
					sourcekit_root_dir(bufnr, on_dir)
				end
			end,
		})

		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_enable = {
				exclude = { "jdtls" },
			},
		})
		vim.lsp.enable("sourcekit")

		local registry = require("mason-registry")
		local packages = {
			"google-java-format",
			"ktlint",
		}
		for _, name in ipairs(packages) do
			local found, mason_package = pcall(registry.get_package, name)
			if not found then
				vim.notify("Mason package is unavailable: " .. name, vim.log.levels.WARN)
			elseif not mason_package:is_installed() and not mason_package:is_installing() then
				mason_package:install()
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserJdtls", { clear = true }),
			pattern = "java",
			callback = function(event)
				start_jdtls(event, capabilities)
			end,
		})
	end,
}
