local M = {}

M.config = function()
  O.lang.csharp = {
    lsp = {
      path = DATA_PATH .. "/lspinstall/csharp/omnisharp/run",
    },
  }
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
  if require("utils").check_lsp_client_active "omnisharp" then
    return
  end

  -- C# language server (csharp/OmniSharp) setup
  require("lspconfig").omnisharp.setup {
    on_attach = require("lsp").common_on_attach,
    cmd = { O.lang.csharp.lsp.path, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
