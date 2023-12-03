-- Color scheme: tokyonight
--local colorschema = {
--	name = "folke/tokyonight.nvim",
--	lazy = false,
--	priority = 1000,
--	config = function()
--		vim.cmd("colorscheme tokyonight")
--	end,
--}

local colorschema = {
	name = "catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			integrations = {
				mason = true,
				noice = true,
				lsp_trouble = true,
				which_key = true,
			},
		})

		vim.cmd("colorscheme catppuccin")
	end,
}

-- Icons
local icons = {
	name = "nvim-tree/nvim-web-devicons",
	lazy = false,
	priority = 1000,
}

-- Blankline
local blankline = {
	name = "lukas-reineke/indent-blankline.nvim",
	lazy = false,
	init = function()
		require("ibl").setup({
			exclude = {
				filetypes = {
					"dashboard",
				},
			},
		})
	end,
}

--UI
local ui = {
	name = "folke/noice.nvim",
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	init = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}

-- Symbols

local symbols = {
	name = "simrat39/symbols-outline.nvim",
	lazy = false,
	init = function()
		require("symbols-outline").setup()
	end,
}

local autotag = {
	name = "windwp/nvim-ts-autotag",
	lazy = false,
	init = function()
		require("nvim-ts-autotag").setup()
	end,
}

-- Mason LSP

local mason_lsp = {
	name = "williamboman/mason-lspconfig.nvim",
	lazy = false,
	init = function(ensure_installed_lsp)
		return function()
			require("neodev").setup({})
			require("mason").setup({
				ui = {
					border = "single",
				},
			})

			local mas = require("mason-lspconfig")
			mas.setup({
				ensure_installed = ensure_installed_lsp,
			})

			mas.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,

				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})
		end
	end,
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
	},
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
	end,
}

-- Telescope
local telescope = {
	name = "nvim-telescope/telescope.nvim",
	lazy = false,
	init = function()
		local tel = require("telescope")
		tel.setup({})
		pcall(tel.load_extension, "fzf")
	end,
}

-- LuaLine
local lualine = {
	name = "nvim-lualine/lualine.nvim",
	lazy = false,
	init = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
		})
	end,
}

-- Dashboard
local dashboard = {
	name = "nvimdev/dashboard-nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}

local lua_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "stylua",
		args = {
			"--search-parent-directories",
			"--stdin-filepath",
			util.escape_path(util.get_current_buffer_file_path()),
			"--",
			"-",
		},
		stdin = true,
	}
end

local prettier_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "prettier",
		args = {
			"--stdin-filepath",
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
		try_node_modules = true,
	}
end

local c_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "clang-format",
		args = {
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_name()),
		},
		stdin = true,
		try_node_modules = true,
	}
end

-- Formatter
local formatter = {
	name = "mhartington/formatter.nvim",
	lazy = false,
	init = function()
		require("formatter").setup({
			filetype = {
				c = {
					c_formatter(),
				},
				lua = {
					lua_formatter,
				},
				javascript = {
					prettier_formatter,
				},
				typescript = {
					prettier_formatter,
				},
				["javascript.jsx"] = {
					prettier_formatter,
				},
				["typescript.jsx"] = {
					prettier_formatter,
				},
				javascriptreact = {
					prettier_formatter,
				},
				typescriptreact = {
					prettier_formatter,
				},
			},
		})
	end,
}

-- Linter
local linter = {
	name = "mfussenegger/nvim-lint",
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
		"lukas-reineke/cmp-under-comparator",
		"onsails/lspkind-nvim",
	},
	init = function()
		local cmp = require("cmp")

		local mapping = {
			["<cr>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm()
				else
					fallback()
				end
			end),
			["<esc>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.abort()
				else
					fallback()
				end
			end),
			["<tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end),
			["<s-tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end),
			["<down>"] = cmp.mapping(function(fallback)
				if cmp.visible_docs() then
					cmp.scroll_docs(5)
				else
					fallback()
				end
			end),
			["<up>"] = cmp.mapping(function(fallback)
				if cmp.visible_docs() then
					cmp.scroll_docs(-5)
				else
					fallback()
				end
			end),
		}

		cmp.setup({
			mapping = mapping,
			formatting = {
				format = require("lspkind").cmp_format({
					with_text = true,
					menu = {
						buffer = "(Buffer)",
						nvim_lsp = "(LSP)",
						path = "(Path)",
						vsnip = "(Snip)",
					},
				}),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				--{ name = "cmdline" },
				{ name = "vsnip" },
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
		})
	end,
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

-- Tree
local tree = {
	name = "nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		require("nvim-tree").setup()
	end,
}

-- Comments
local comments = {
	name = "folke/todo-comments.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

local pairs = {
	name = "windwp/nvim-autopairs",
	lazy = false,
	init = function()
		require("nvim-autopairs").setup({})
	end,
}

-- Diagnostic
local diagnostic = {
	name = "folke/trouble.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}

-- Which key
local which_key = {
	name = "folke/which-key.nvim",
	lazy = false,
	priority = 0,
	init = function()
		local wk = require("which-key")
		wk.setup()
	end,
}

return {
	setup = function(ensure_installed_mason, ensure_installed_treesitter)
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
				blankline.name,
				lazy = blankline.lazy,
				init = blankline.init,
			},
			{
				ui.name,
				lazy = ui.lazy,
				dependencies = ui.dependencies,
				init = ui.init,
			},
			{
				symbols.name,
				lazy = symbols.lazy,
				init = symbols.init,
			},
			{
				autotag.name,
				lazy = autotag.lazy,
				init = autotag.init,
			},
			{
				mason_lsp.name,
				lazy = mason_lsp.lazy,
				dependencies = mason_lsp.dependencies,
				init = mason_lsp.init(ensure_installed_mason),
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
				init = formatter.init,
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
				tree.name,
				lazy = tree.lazy,
				dependencies = tree.dependencies,
				init = tree.init,
			},
			{
				comments.name,
				lazy = comments.lazy,
				dependencies = comments.dependencies,
			},
			{
				pairs.name,
				lazy = pairs.lazy,
				init = pairs.init,
			},
			{
				diagnostic.name,
				lazy = diagnostic.lazy,
				dependencies = diagnostic.dependencies,
			},
			{
				which_key.name,
				lazy = which_key.lazy,
				priority = which_key.priority,
				init = which_key.init,
			},
		})
	end,
}
