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

local go_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "gofmt",
		args = {
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
	}
end

local elixir_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "mix format",
		args = {
			"--stdin-filename",
			util.escape_path(util.get_current_buffer_file_path()),
			"-",
		},
		stdin = true,
	}
end

local haskell_formatter = function()
	local util = require("formatter.util")
	return {
		exe = "fourmolu",
		args = {
			"-i",
			util.escape_path(util.get_current_buffer_file_path()),
		},
	}
end

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
					c_formatter,
				},
				cpp = {
					c_formatter,
				},
				elixir = {
					elixir_formatter,
				},
				heex = {
					elixir_formatter,
				},
				go = {
					go_formatter,
				},
				haskell = {
					haskell_formatter,
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
	init = function()
		require("zen-mode").setup({
			window = {
				width = 0.7,
			},
			plugins = {
				kitty = {
					enabled = false,
					font = "+4",
				},
			},
		})
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
			require("plugins.colorschema"),
			require("plugins.icons"),
			require("plugins.blankline"),
			require("plugins.ui"),
			require("plugins.symbols"),
			require("plugins.autotag"),
			require("plugins.telescope"),
			require("plugins.focus"),
			require("plugins.ufo"),
			require("plugins.statuscol"),
			require("plugins.trouble"),
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
				init = zen.init,
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
				which_key.name,
				lazy = which_key.lazy,
				priority = which_key.priority,
				init = which_key.init,
			},
		})
	end,
}
