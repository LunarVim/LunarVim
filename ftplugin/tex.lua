if require("lv-utils").check_lsp_client_active "texlab" then
  return
end

require("lspconfig").texlab.setup {
  cmd = { DATA_PATH .. "/lspinstall/latex/texlab" },
  on_attach = require("lsp").common_on_attach,
}
