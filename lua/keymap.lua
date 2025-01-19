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

function OilRoot()
  require("oil").toggle_float()
end

function Peek()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.cmd("Lspsaga hover_doc")
  end
end

return {
  setup = function()
    local set = vim.keymap.set
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

    -- TODO

    set('v', '<D-c>', '"+y') -- Copy
    set('n', '<D-v>', '"+P') -- Paste normal mode
    set('v', '<D-v>', '"+P') -- Paste visual mode
    set('c', '<D-v>', '<C-R>+')

    set("n", "<leader>z", Format, { desc = "Format file" })

    set("n", "zR", OpenAll, { desc = "Open Folds" })
    set("n", "zM", CloseAll, { desc = "Close Folds" })

    set("n", "<leader>w", FlashJump, { desc = "Flash" })
    set("n", "<leader>e", FlashTreesitterSearch, { desc = "Flash Search" })
    set("n", "<leader>r", FlashTreesitter, { desc = "Flash Treesitter" })

    set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Window quit" })
    set("n", "<leader><leader>w", "<cmd>wqa<cr>", { desc = "Quit" })
    set("n", "<leader>l", "<C-w>l", { desc = "Window right" })
    set("n", "<leader>h", "<C-w>h", { desc = "Window left" })
    set("n", "<leader>k", "<C-w>k", { desc = "Window up" })
    set("n", "<leader>j", "<C-w>j", { desc = "Window down" })

    set("n", "<leader><leader>l", "<C-w>L", { desc = "Window move right" })
    set("n", "<leader><leader>h", "<C-w>H", { desc = "Window move left" })
    set("n", "<leader><leader>k", "<C-w>K", { desc = "Window move up" })
    set("n", "<leader><leader>j", "<C-w>J", { desc = "Window move down" })

    set("n", "<leader>o", "<cmd>vertical resize +5<cr>", { desc = "Resize vertical +" })
    set("n", "<leader>y", "<cmd>vertical resize -5<cr>", { desc = "Resize vertical -" })
    set("n", "<leader>i", "<cmd>resize +5<cr>", { desc = "Resize horizontal +" })
    set("n", "<leader>u", "<cmd>resize -5<cr>", { desc = "Resize horizontal -" })

    set("n", "<leader>n", "<cmd>sp<cr>", { desc = "Split horizontal" })
    set("n", "<leader>m", "<cmd>vs<cr>", { desc = "Split vertical" })

    set("n", "<leader>c", "<C-o>", { desc = "Jump back" })
    set("n", "<leader>v", "<C-i>", { desc = "Jump forward" })

    set("n", "<leader>a", OilRoot, { desc = "Oil tree" })
    set("n", "<leader>ss", ":Telescope file_browser<CR>", { desc = "Root" })
    set("n", "<leader>sa", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Current" })
    set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Show buffers" })
    set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find fils" })
    set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    set("n", "<leader><leader>f", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "Live grep under" })
    set("v", "<leader><leader>f", live_grep_args_shortcuts.grep_visual_selection, { desc = "Live grep selected" })

    set("n", "<leader><leader>m", "<cmd>tabnew<cr>", { desc = "New Tab" })
    set("n", "<leader><leader>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

    set("n", "<leader>x", "<cmd>noh<cr>", { desc = "Hide highlight" })

    set("n", "<leader>d", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", { desc = "Trouble" })

    set("n", "<leader><leader>z", "<cmd>ZenMode<cr>", { desc = "Zen mode" })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        set("n", "gD", vim.lsp.buf.declaration, opts)
        set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
        set("n", "gs", "<cmd>Lspsaga goto_type_definition<cr>", opts)
        set("n", "K", Peek, opts)
        set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
        set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
        set("n", "<leader><leader>r", "<cmd>Lspsaga rename<cr>", opts)
        set("n", "<leader><leader>a", "<cmd>Lspsaga code_action<cr>", opts)
      end,
    })
  end,
}
