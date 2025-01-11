local plugins = {
  require("plugins.colorschema"),
  require("plugins.comment"),
  require("plugins.which"),
  require("plugins.noice"),
  require("plugins.treesitter"),
  require("plugins.statusline"),
  require("plugins.telescope"),
  require("plugins.lsp"),
  require("plugins.formater"),
  require("plugins.save"),
  require("plugins.autotag"),
  require("plugins.autopair"),
  require("plugins.completion"),
  require("plugins.flash"),
  require("plugins.blankline"),
  require("plugins.oil"),
  require("plugins.ufo"),
  require("plugins.statuscol"),
  require("plugins.session"),
  require("plugins.project"),
  require("plugins.trouble"),
  require("plugins.macro"),
  require("plugins.saga"),
  require("plugins.tabs"),
  require("plugins.zen"),
  require("plugins.tailwind"),
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
