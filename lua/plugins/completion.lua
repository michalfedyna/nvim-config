return {
  "saghen/blink.cmp",
  branch = "main",
  dependencies = {
    "saghen/blink.lib",
  },
  build = function()
    require("blink.cmp").build():pwait()
  end,
  opts = {
    keymap = {
      preset = "none",
      ["<CR>"] = { "accept", "fallback" },
      ["<Esc>"] = { "hide", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Down>"] = {
        function(cmp)
          return cmp.scroll_documentation_down(5)
        end,
        "fallback",
      },
      ["<Up>"] = {
        function(cmp)
          return cmp.scroll_documentation_up(5)
        end,
        "fallback",
      },
      ["<D-a>"] = { "show" },
    },
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = { enabled = false },
      },
      menu = {
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind",              gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
      },
    },
    fuzzy = { implementation = "rust" },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    sources = {
      default = { "lazydev", "lsp", "buffer", "path", "snippets" },
      per_filetype = {
        markdown = { "lsp", "buffer", "path" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = { fallbacks = {} },
        path = { fallbacks = {} },
      },
    },
  },
}
