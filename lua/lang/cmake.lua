local M = {}

M.config = function()
  O.lang.cmake = {
    lsp_path = DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server",
    formatter = {
      exe = "clang-format",
      args = {},
    },
  }
end

M.format = function()
  -- TODO: implement formatters (if applicable)
  return "No formatters configured!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "cmake" then
    return
  end

  require("lspconfig").cmake.setup {
    cmd = { O.lang.cmake.lsp_path },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "cmake" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
