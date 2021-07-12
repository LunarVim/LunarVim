if not require("lv-utils").check_lsp_client_active "cssls" then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- npm install -g vscode-css-languageserver-bin
  require("lspconfig").cssls.setup {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp").common_on_attach,
    capabilities = capabilities,
  }
end

vim.cmd "setl ts=2 sw=2"
