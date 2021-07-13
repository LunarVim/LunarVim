if require("lv-utils").check_lsp_client_active "cmake" then
  return
end

require("lspconfig").cmake.setup {
  cmd = { DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server" },
  on_attach = require("lsp").common_on_attach,
  filetypes = { "cmake" },
}
