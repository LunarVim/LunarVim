local M = {}

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "cmake" then
    return
  end

  require("lspconfig").cmake.setup {
    cmd = { O.lang.cmake.lsp.path },
    on_attach = require("lsp").common_on_attach,
  }
end

return M
