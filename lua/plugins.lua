local plugins = {
	require("plugins.autopair"),
	require("plugins.autotag"),
  require("plugins.animate"),
	require("plugins.blankline"),
	require("plugins.colorschema"),
	require("plugins.comment"),
	require("plugins.files"),
	require("plugins.flash"),
	require("plugins.formater"),
	require("plugins.lazydev"),
	require("plugins.lsp"),
	require("plugins.macro"),
	require("plugins.markdown"),
	require("plugins.noice"),
	require("plugins.overseer"),
	require("plugins.project"),
	require("plugins.saga"),
	require("plugins.save"),
	require("plugins.session"),
	require("plugins.statuscol"),
	require("plugins.statusline"),
	require("plugins.tabs"),
	require("plugins.tailwind"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.trouble"),
	require("plugins.ufo"),
	require("plugins.which"),
	require("plugins.zen"),
	require("plugins.completion"),
}

return {
	setup = function()
		local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		if not (vim.uv or vim.loop).fs_stat(lazypath) then
			vim.fn.system({
				"git",
				"clone",
				"--filter=blob:none",
				"https://github.com/folke/lazy.nvim.git",
				"--branch=stable", -- latest stable release
				lazypath,
			})
		end
		vim.opt.rtp:prepend(lazypath)

		require("lazy").setup(plugins)
	end,
}
