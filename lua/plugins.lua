-- Color scheme: tokyonight
local colorschema = {
    name = "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme tokyonight")
    end
}

-- Icons
local icons = {
    name = "nvim-tree/nvim-web-devicons",
    lazy = false,
    priority = 1000,
}

-- Mason
local mason = {
    name = "williamboman/mason.nvim",
    lazy = false,
}

-- Mason LSP
local mason_lsp = {
    name = "williamboman/mason-lspconfig.nvim",
    lazy = false,
}

-- LSP
local lsp = {
    name = "neovim/nvim-lspconfig",
    lazy = false,
}

-- Treesitter
local treesitter = {
    name = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    init = function(ensure_installed_treesitter)
        return function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = ensure_installed_treesitter,
                autoinstall = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end
    end
}

-- Telescope
local telescope = {
    name = "nvim-telescope/telescope.nvim",
    lazy = false,
    init = function()
        local tel = require("telescope")
        tel.setup({})
        pcall(tel.load_extension, "fzf")
    end
}

-- LuaLine
local lualine = {
    name = "nvim-lualine/lualine.nvim",
    lazy = false,
    init = function()
        require("lualine").setup({
            options = {
                theme = "tokyonight",
            }
        })
    end
}

-- Dashboard
local dashboard = {
    name = "nvimdev/dashboard-nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}

-- Formatter
local formatter = {
    name = "stevearc/conform.nvim",
    lazy = false,
}

-- Linter
local linter = {
    name = "nvim-lua/plenary.nvim",
    lazy = false,
}

-- Completion
local completion = {
    name = "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    },
    init = function()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "cmdline" },
                { name = "vsnip" },
            },
        })
    end
}

-- Flash
local flash = {
    name = "folke/flash.nvim",
    lazy = false,
}

-- Zen
local zen = {
    name = "folke/zen-mode.nvim",
    lazy = false,
}

-- Comments
local comments = {
    name = "folke/todo-comments.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

-- Which key
local which_key = {
    name = "folke/which-key.nvim",
    lazy = false,
    priority = 0,
    init = function(keymap)
        return function()
            local wk = require("which-key")
            wk.setup()
            wk.register(keymap, { prefix = "<leader>" })
        end
    end
}

return {
    setup = function(keymap, ensure_installed_lsp, ensure_installed_treesitter, ensure_installed_linter, ensure_installed_formatter)
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.loop.fs_stat(lazypath) then
            vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable",
                lazypath,
            })
        end
        vim.opt.rtp:prepend(lazypath)

        require("lazy").setup({
            {
                colorschema.name,
                priority = colorschema.priority,
                lazy = colorschema.lazy,
                config = colorschema.config,
            },
            {
                icons.name,
                priority = icons.priority,
                lazy = icons.lazy,
            },
            {
                mason.name,
                lazy = mason.lazy,
            },
            {
                mason_lsp.name,
                lazy = mason_lsp.lazy,
            },
            {
                lsp.name,
                lazy = lsp.lazy,
            },
            {
                treesitter.name,
                lazy = treesitter.lazy,
                init = treesitter.init(ensure_installed_treesitter),
            },
            {
                telescope.name,
                lazy = telescope.lazy,
            },
            {
                lualine.name,
                lazy = lualine.lazy,
                init = lualine.init,
            },
            {
                dashboard.name,
                lazy = dashboard.lazy,
            },
            {
                formatter.name,
                lazy = formatter.lazy,
            },
            {
                linter.name,
                lazy = linter.lazy,
            },
            {
                completion.name,
                lazy = completion.lazy,
                dependencies = completion.dependencies,
                init = completion.init,
            },
            {
                flash.name,
                lazy = flash.lazy,
            },
            {
                zen.name,
                lazy = zen.lazy,
            },
            {
                comments.name,
                lazy = comments.lazy,
                dependencies = comments.dependencies,
            },
            {
                which_key.name,
                lazy = which_key.lazy,
                priority = which_key.priority,
                init = which_key.init(keymap),
            },
        })
    end
}
