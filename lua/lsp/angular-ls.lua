-- TODO: find correct root filetype
-- :LspInstall angular
require("lspconfig").angularls.setup {
  cmd = { require("lsp.installer").get_langserver_path "angular", "--stdio" },
  on_attach = require("lsp").common_on_attach,
}
