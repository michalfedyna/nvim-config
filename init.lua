-- Global settings
vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.signcolumn = "yes:1"
vim.opt.termguicolors = true

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

local set = vim.keymap.set

-- Utils
set("n", "<leader>b", "$a;<esc>", { desc = "Add semicolon" })

-- Windows
set("n", "<leader>q", "<C-w>q", { desc = "Window quit" })
set("n", "<leader>l", "<C-w>l", { desc = "Window right" })
set("n", "<leader>h", "<C-w>h", { desc = "Window left" })
set("n", "<leader>k", "<C-w>k", { desc = "Window up" })
set("n", "<leader>j", "<C-w>j", { desc = "Window down" })

set("n", "<leader><leader>l", "<C-w>L", { desc = "Window move right" })
set("n", "<leader><leader>h", "<C-w>H", { desc = "Window move left" })
set("n", "<leader><leader>k", "<C-w>K", { desc = "Window move up" })
set("n", "<leader><leader>j", "<C-w>J", { desc = "Window move down" })

set("n", "<leader>o", "<cmd>vertical resize +10<cr>", { desc = "Resize" })
set("n", "<leader>y", "<cmd>vertical resize -10<cr>", { desc = "Resize" })
set("n", "<leader>i", "<cmd>resize +10<cr>", { desc = "Resize" })
set("n", "<leader>u", "<cmd>resize -10<cr>", { desc = "Resize" })

set("n", "<leader>m", "<cmd>sp<cr>", { desc = "Split horizontal" })
set("n", "<leader>n", "<cmd>vs<cr>", { desc = "Split vertical" })

set("n", "<leader>c", "<C-o>", { desc = "Jump back" })
set("n", "<leader>v", "<C-i>", { desc = "Jump forward" })

-- Telescope
set("n", "<leader>d", "<cmd>Telescope buffers<cr>", { desc = "Show buffers" })
set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find fils" })
set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })

-- File Tree
set("n", "<leader>a", "<cmd>NvimTreeToggle<cr>", { desc = "Tree toogle" })

-- Symbols
set("n", "<leader>s", "<cmd>SymbolsOutline<cr>", { desc = "Outline toogle" })

-- Format
set("n", "<leader>z", "<cmd>Format<cr>", { desc = "Format file" })

-- Zenmode
set("n", "<leader><leader>z", "<cmd>ZenMode<cr>", { desc = "Zenmode toogle" })

-- Search
set("n", "<leader>x", "<cmd>noh<cr>", { desc = "Hide highlight" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- Language support
local mason = {
	"clangd",
	"cmake",
	"lua_ls",
	"tsserver",
	"html",
}

local treesitter = {
	"cmake",
	"c",
	"cpp",
	"haskell",
	"heex",
	"lua",
	"typescript",
	"html",
	"erlang",
	"elixir",
}

-- Load plugins
require("plugins").setup(mason, treesitter)
