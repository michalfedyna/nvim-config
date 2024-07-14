local ensure_installed = { "clangd", "neocmake", "html", "lua_ls", "tsserver", "eslint", "elixirls" }

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = require('cmp_nvim_lsp').default_capabilities()
        })
      end,
    })
  end,
}
