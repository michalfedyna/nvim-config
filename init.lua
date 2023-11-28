-- Global settings
vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.relativenumber = true
vim.opt.termguicolors = true

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Language support
local mason = {
    -- Lua
	"clangd",
    "lua_ls",
	"tsserver",
}

local treesitter = {
	"cmake",
	"c",
	"cpp",
    "lua",
	"typescript",
}

local keymap = function()
    local wk = require("which-key")
    local cmp = require("cmp")

    wk.register({
        -- Telescope
        ["<leader>"] = { "<cmd>Telescope buffers<cr>", "Open buffers" },
        ["f"] = { "<cmd>Telescope find_files<cr>", "Find files" },
        ["g"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
        -- Files Tree
        ["d"] = { "<cmd>NvimTreeToggle<cr>", "Toggle tree" },
        ["e"] = { "<cmd>NvimTreeFocus<cr>", "Focus tree" },
        -- ZenMode
        ["<D-z>"] = { "<cmd>ZenMode<cr>", "Toggle ZenMode" },
        -- Formatting
        ["z"] = { "<cmd>Format<cr>", "Format" },
        -- Diagnostics
    }, { mode = "n", prefix = "<leader>" })

    wk.register({
        -- Cmp
        ["<D-j>"] = { function()
            if cmp.visible() then
                cmp.select_next_item()
            end
        end, "Next item" },
        ["<D-k>"] = { function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, "Previous item" },
        ["<D-l>"] = { function()
            if cmp.visible() then
                cmp.confirm()
            end
        end, "Confirm" },
        ["<D-h>"] = { function()
            if cmp.visible() then
                cmp.close()
            end
        end, "Cancel" },
        ["<D-n>"] = { function()
            if cmp.visible() then
                cmp.open_docs()
            end
        end, "Open docs" },
        ["<D-m>"] = { function()
            if cmp.visible_docs() then
                cmp.scroll_docs(4)
            end
        end, "Scroll down docs" },
        ["<D-,>"] = { function()
            if cmp.visible_docs() then
                cmp.scroll_docs(-4)
            end
        end, "Scroll up docs" },

    }, { mode = "i", prefix = "" })
end

-- Load plugins
require("plugins").setup(keymap, mason, treesitter)
