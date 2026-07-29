local ensure_installed = {
  "astro",
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "elixir",
  "erlang",
  "go",
  "heex",
  "html",
  "java",
  "kotlin",
  "lua",
  "objc",
  "rust",
  "swift",
  "vimdoc",
  "luadoc",
  "vim",
  "markdown",
  "dockerfile",
  "typescript",
  "tsx",
  "terraform"
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup()
    vim.treesitter.language.register("objc", "objcpp")
    treesitter.install(ensure_installed)

    local filetypes = {}
    local seen = {}
    for _, language in ipairs(ensure_installed) do
      for _, filetype in ipairs(vim.treesitter.language.get_filetypes(language)) do
        if not seen[filetype] then
          seen[filetype] = true
          table.insert(filetypes, filetype)
        end
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      pattern = filetypes,
      callback = function(event)
        if not pcall(vim.treesitter.start, event.buf) then
          return
        end

        local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
        if language and vim.treesitter.query.get(language, "indents") then
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
