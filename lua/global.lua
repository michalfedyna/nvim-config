return {
  setup = function()
    vim.g.maplocalleader = " "
    vim.g.mapleader = " "

    vim.wo.relativenumber = true
    vim.wo.number = true

    vim.opt.termguicolors = true
    vim.opt.wrap = true

    vim.o.timeout = true
    vim.o.timeoutlen = 300

    vim.o.ignorecase = true
    vim.o.smartcase = true

    vim.o.tabstop = 2
    vim.o.shiftwidth = 2
    vim.o.expandtab = true
    vim.o.smartindent = true

    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.g.neovide_input_use_logo = 1
  end,
}
