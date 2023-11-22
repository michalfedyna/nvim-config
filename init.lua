-- Global settings
vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.wo.relativenumber = true
vim.opt.termguicolors = true

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true

-- Language support
local lsp = {}

local treesitter = {
    "lua",
}

local linter = {}

local formatter = {}

-- Keymap (all prefixed with <leader>)
local keymap = {
    -- Telescope
    ["<leader>"] = { "<cmd>Telescope buffers<cr>", "Open buffers" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find files" }
}

-- Load plugins
require("plugins").setup(keymap, lsp, treesitter, linter, formatter)
