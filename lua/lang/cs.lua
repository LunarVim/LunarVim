local M = {}

M.config = function()
  -- TODO: implement config for language
  return "No config available!"
end

M.format = function()
  -- TODO: implement formatter for language
  return "No formatter available!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "omnisharp" then
    return
  end

  -- C# language server (csharp/OmniSharp) setup
  require("lspconfig").omnisharp.setup {
    on_attach = require("lsp").common_on_attach,
    root_dir = require("lspconfig").util.root_pattern(".sln", ".git"),
    cmd = { DATA_PATH .. "/lspinstall/csharp/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
