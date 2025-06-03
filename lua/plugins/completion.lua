return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require('lspkind')

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
      ["<D-a>"] = cmp.mapping.complete(),
    }

    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'vsnip' },
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = mapping,
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
        }),
      },
    })

    cmp.setup.filetype('markdown', {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      })
    })
  end
}
