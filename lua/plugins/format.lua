return {
	"stevearc/conform.nvim",
	lazy = false,
	init = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				["javascript.jsx"] = { "prettier" },
				["typescript.jsx"] = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				elixir = { "mix format" },
				heex = { "mix format" },
				sh = { "shfmt" },
				markdown = { "prettier" },
			},
		})
	end,
}
