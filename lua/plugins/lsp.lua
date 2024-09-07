local ensure_installed = {
  "clangd",
  "neocmake",
  "html",
  "lua_ls",
  "tsserver",
  "eslint",
  "elixirls",
  "terraformls",
  "cssls"
}

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
        if server_name == "html" then
          require("lspconfig")[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            filetypes = { "html", "heex" }
          })
        elseif server_name == "emmet_language_server" then
          require("lspconfig")[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            filetypes = { "html", "heex", "typescriptreact", "javascriptreact" }
          })
        elseif server_name == "tailwindcss" then
          require("lspconfig")[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          })
        else
          require("lspconfig")[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities()
          })
        end
      end,
    })
  end,
}
