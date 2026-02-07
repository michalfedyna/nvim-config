local function Format()
	require("conform").format({ lsp_fallback = true, quiet = true }, function(_, _)
		vim.cmd("wa")
	end)
end

local function OpenAll()
	require("ufo").openAllFolds()
end

local function CloseAll()
	require("ufo").closeAllFolds()
end

function FlashJump()
	require("flash").jump()
end

function FlashTreesitter()
	require("flash").treesitter()
end

function FlashTreesitterSearch()
	require("flash").treesitter_search()
end

function Files()
	require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end

function Peek()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.cmd("Lspsaga hover_doc")
	end
end

---@type Keymap[]
local keymaps = {
	-- TODO
	{ "n", "<leader>p", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Brakepoint" },

	-- GIT
	{ "n", "<leader><leader>g", "<cmd>Neogit<cr>", desc = "Neogit" },

	-- Clipboard
	{ "v", "<D-c>", '"+y' },
	{ "n", "<D-v>", '"+P' },
	{ "v", "<D-v>", '"+P' },
	{ "c", "<D-v>", "<C-R>+" },

	-- Scrolling
	{ "n", "<C-j>", "<C-f>" },
	{ "n", "<C-k>", "<C-b>" },
	{ "n", "<C-l>", "<C-d>" },
	{ "n", "<C-h>", "<C-u>" },

	-- Sync vertical
	{
		"n",
		"<leader><leader>s",
		":<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>",
		desc = "Sync vertical",
	},
	{ "n", "<leader><leader>d", ":<C-u>:set so=0 noscb<CR>", desc = "Stop sync" },

	-- Format
	{ "n", "<leader>z", Format, desc = "Format file" },

	-- Folds
	{ "n", "zR", OpenAll, desc = "Open Folds" },
	{ "n", "zM", CloseAll, desc = "Close Folds" },

	-- Flash
	{ "n", "<leader>w", FlashJump, desc = "Flash" },
	{ "n", "<leader>e", FlashTreesitterSearch, desc = "Flash Search" },
	{ "n", "<leader>r", FlashTreesitter, desc = "Flash Treesitter" },

	-- Window management
	{ "n", "<leader>q", "<cmd>quit<cr>", desc = "Window quit" },
	{ "n", "<leader><leader>w", "<cmd>wqa<cr>", desc = "Quit" },
	{ "n", "<leader>l", "<C-w>l", desc = "Window right" },
	{ "n", "<leader>h", "<C-w>h", desc = "Window left" },
	{ "n", "<leader>k", "<C-w>k", desc = "Window up" },
	{ "n", "<leader>j", "<C-w>j", desc = "Window down" },

	-- Window move
	{ "n", "<leader><leader>l", "<C-w>L", desc = "Window move right" },
	{ "n", "<leader><leader>h", "<C-w>H", desc = "Window move left" },
	{ "n", "<leader><leader>k", "<C-w>K", desc = "Window move up" },
	{ "n", "<leader><leader>j", "<C-w>J", desc = "Window move down" },

	-- Resize
	{ "n", "<leader>o", "<cmd>vertical resize +5<cr>", desc = "Resize vertical +" },
	{ "n", "<leader>y", "<cmd>vertical resize -5<cr>", desc = "Resize vertical -" },
	{ "n", "<leader>i", "<cmd>resize +5<cr>", desc = "Resize horizontal +" },
	{ "n", "<leader>u", "<cmd>resize -5<cr>", desc = "Resize horizontal -" },

	-- Split
	{ "n", "<leader>n", "<cmd>sp<cr>", desc = "Split horizontal" },
	{ "n", "<leader>m", "<cmd>vs<cr>", desc = "Split vertical" },

	-- Jumplist
	{ "n", "<leader>c", "<C-o>", desc = "Jump back" },
	{ "n", "<leader>v", "<C-i>", desc = "Jump forward" },

	-- File navigation
	{ "n", "<leader>a", Files, desc = "Files tree" },
	{ "n", "<leader>ss", ":Telescope file_browser<CR>", desc = "Root" },
	{ "n", "<leader>sa", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Current" },
	{ "n", "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Show buffers" },
	{ "n", "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find fils" },
	{ "n", "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
	{
		"n",
		"<leader><leader>f",
		function()
			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
		end,
		desc = "Live grep under",
	},
	{
		"v",
		"<leader><leader>f",
		function()
			require("telescope-live-grep-args.shortcuts").grep_visual_selection()
		end,
		desc = "Live grep selected",
	},

	-- Tabs
	{ "n", "<leader><leader>m", "<cmd>tabnew<cr>", desc = "New Tab" },
	{ "n", "<leader><leader>q", "<cmd>tabclose<cr>", desc = "Close Tab" },

	-- Misc
	{ "n", "<leader>x", "<cmd>noh<cr>", desc = "Hide highlight" },
	{ "n", "<leader>d", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "Trouble" },
	{ "n", "<leader><leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" },
	{ "n", "<leader><leader>x", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown" },
}

---@type Keymap[]
local lsp_keymaps = {
	{ "n", "gD", vim.lsp.buf.declaration },
	{ "n", "gd", "<cmd>Lspsaga goto_definition<cr>" },
	{ "n", "gs", "<cmd>Lspsaga goto_type_definition<cr>" },
	{ "n", "K", Peek },
	{ "n", "gi", "<cmd>Telescope lsp_implementations<cr>" },
	{ "n", "gr", "<cmd>Telescope lsp_references<cr>" },
	{ "n", "<leader><leader>r", "<cmd>Lspsaga rename<cr>" },
	{ "n", "<leader><leader>a", "<cmd>Lspsaga code_action<cr>" },
}

---@class Keymap
---@field [1] string|string[]        -- mode(s)
---@field [2] string                  -- lhs (key sequence)
---@field [3] string|function         -- rhs (command or function)
---@field desc? string                -- description for which-key
---@field opts? vim.keymap.set.Opts   -- extra options (silent, expr, etc.)

---@param maps Keymap[]
---@param extra_opts? vim.keymap.set.Opts
local function apply(maps, extra_opts)
	for _, map in ipairs(maps) do
		local o = {}
		if map.desc then
			o.desc = map.desc
		end
		if map.opts then
			o = vim.tbl_extend("force", o, map.opts)
		end
		if extra_opts then
			o = vim.tbl_extend("force", o, extra_opts)
		end
		vim.keymap.set(map[1], map[2], map[3], o)
	end
end

return {
	setup = function()
		apply(keymaps)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				apply(lsp_keymaps, { buffer = ev.buf })
			end,
		})
	end,
}
