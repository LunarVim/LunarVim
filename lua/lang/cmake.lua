local M = {}

local formatter_profiles = {
  ["cmake-format"] = {
    exe = "cmake-format",
    args = { "-i" },
    stdin = false,
    tempfile_prefix = ".formatter",
  },
}

M.config = function()
  O.lang.cmake = {
    formatters = {
      "cmake-format",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server",
    },
  }
end

M.format = function()
  O.formatters.filetype["cmake"] = require("lv-utils").wrap_formatters(O.lang.cmake.formatters, formatter_profiles)
  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
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
    cmd = { O.lang.cmake.lsp.path },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "cmake" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
