-- C# language server (csharp/OmniSharp) setup
require("lspconfig").omnisharp.setup{
  on_attach = require("lsp").common_on_attach,
  root_dir = require("lspconfig").util.root_pattern(".sln",".git"),
  cmd = { DATA_PATH .. "/lspinstall/csharp/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
}
