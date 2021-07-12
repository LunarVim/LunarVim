-- Example configuations here: https://github.com/mattn/efm-langserver
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
local M = {}

M.setup = function()
  local tsserver_args = {}

  if O.lang.tsserver.linter == "eslint" or O.lang.tsserver.linter == "eslint_d" then
    local eslint = {
      lintCommand = O.lang.tsserver.linter .. " -f unix --stdin --stdin-filename   {INPUT}",
      lintStdin = true,
      lintFormats = { "%f:%l:%c: %m" },
      lintIgnoreExitCode = true,
      formatCommand = O.lang.tsserver.linter .. " --fix-to-stdout --stdin  --stdin-filename=${INPUT}",
      formatStdin = true,
    }
    table.insert(tsserver_args, eslint)
  end

  require("lspconfig").efm.setup {
    -- init_options = {initializationOptions},
    cmd = { DATA_PATH .. "/lspinstall/efm/efm-langserver" },
    init_options = { documentFormatting = true, codeAction = false },
    root_dir = require("lspconfig").util.root_pattern(".git/", "package.json"),
    filetypes = {
      "vue",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "javascript.jsx",
      "typescript.tsx",
    },
    settings = {
      rootMarkers = { ".git/", "package.json" },
      languages = {
        vue = tsserver_args,
        javascript = tsserver_args,
        javascriptreact = tsserver_args,
        ["javascript.jsx"] = tsserver_args,
        typescript = tsserver_args,
        ["typescript.tsx"] = tsserver_args,
        typescriptreact = tsserver_args,
      },
    },
  }
end

return M
