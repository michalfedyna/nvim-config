local function Format()
	require("conform").format({ lsp_format = "fallback", quiet = true }, function(_, _)
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
		vim.lsp.buf.hover()
	end
end

---@type Keymap[]
local keymaps = {
	-- Clipboard
	{ { "n", "v" }, "y", '"+y' },
	{ "n", "Y", '"+y$' },
	{ { "n", "v" }, "p", '"+p' },
	{ { "n", "v" }, "P", '"+P' },
	{ { "n", "v" }, "x", '"+x' },
	{ { "n", "v" }, "X", '"+X' },
	{ { "n", "v" }, "d", '"+d' },
	{ "n", "D", '"+D' },

	-- Scrolling
	{ "n", "<C-j>", "<C-f>" },
	{ "n", "<C-k>", "<C-b>" },
	{ "n", "<C-l>", "<C-d>" },
	{ "n", "<C-h>", "<C-u>" },

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
	{ "n", "<leader><leader>o", "<cmd>vertical resize +5<cr>", desc = "Resize vertical +" },
	{ "n", "<leader><leader>y", "<cmd>vertical resize -5<cr>", desc = "Resize vertical -" },
	{ "n", "<leader><leader>i", "<cmd>resize +5<cr>", desc = "Resize horizontal +" },
	{ "n", "<leader><leader>u", "<cmd>resize -5<cr>", desc = "Resize horizontal -" },

	-- Split
	{ "n", "<leader><leader>v", "<cmd>sp<cr>", desc = "Split horizontal" },
	{ "n", "<leader><leader>b", "<cmd>vs<cr>", desc = "Split vertical" },

	-- Jumplist
	{ "n", "<leader>c", "<C-o>", desc = "Jump back" },
	{ "n", "<leader>v", "<C-i>", desc = "Jump forward" },

	-- File navigation
	{ "n", "<leader>a", Files, desc = "Files tree" },
	{ "n", "<leader>sr", ":Telescope file_browser<CR>", desc = "Browse root" },
	{ "n", "<leader>sc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Browse current" },
	{ "n", "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Show buffers" },
	{ "n", "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
	{ "n", "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
	{
		"n",
		"<leader>sw",
		function()
			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
		end,
		desc = "Grep word",
	},
	{
		"v",
		"<leader>sv",
		function()
			require("telescope-live-grep-args.shortcuts").grep_visual_selection()
		end,
		desc = "Grep selection",
	},

	-- Tabs
	{ "n", "<leader><leader>m", "<cmd>tabnew<cr>", desc = "New Tab" },
	{ "n", "<leader><leader>q", "<cmd>tabclose<cr>", desc = "Close Tab" },

	-- Toggles
	{ "n", "<leader>td", ":DiffviewOpen ", desc = "Open Diffview" },
	{ "n", "<leader>tz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
	{ "n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown" },

	-- Misc
	{ "n", "<leader>x", "<cmd>noh<cr>", desc = "Hide highlight" },
	{ "n", "<leader>d", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "Trouble" },
}

---@type Keymap[]
local lsp_keymaps = {
	{ "n", "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
	{ "n", "gd", vim.lsp.buf.definition, desc = "Go to definition" },
	{ "n", "K", Peek, desc = "Hover documentation" },
	{ "n", "grt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
	{ "n", "gri", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementations" },
	{ "n", "grr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references" },
	{ "n", "grn", vim.lsp.buf.rename, desc = "Rename symbol" },
	{ { "n", "v" }, "gra", vim.lsp.buf.code_action, desc = "Code action" },
	{ "n", "gO", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
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
