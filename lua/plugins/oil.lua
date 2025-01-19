return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      keymaps = {
        ["<Esc>"] = "actions.close",
        ["<D-j>"] = "actions.preview_scroll_down",
        ["<D-k>"] = "actions.preview_scroll_up",
      },
      columns = {
        "icon",
      },
      delete_to_trash = true,
      watch_for_changes = true,
      float = {
        max_width = 0.8,
        preview_split = "right",
      },
      view_options = {
        show_hidden = true,
      }
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview({ vertical = true, split = 'botright' })
        end
      end),
    })
  end
}
