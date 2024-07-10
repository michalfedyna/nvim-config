local ensure_installed = {
	"bash",
	"c",
	"cmake",
	"cpp",
	"elixir",
	"erlang",
	"go",
	"heex",
	"html",
	"lua",
	"typescript",
  "tsx",
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = ensure_installed,
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
