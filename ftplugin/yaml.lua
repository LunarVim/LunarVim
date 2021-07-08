if require("lv-utils").check_lsp_client_active "yamlls" then
  return
end

-- npm install -g yaml-language-server
require("lspconfig").yamlls.setup {
  cmd = { DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server", "--stdio" },
  on_attach = require("lsp").common_on_attach,
}
vim.cmd "setl ts=2 sw=2 ts=2 ai et"
