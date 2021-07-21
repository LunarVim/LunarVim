local M = {}

M.config = function()
  O.lang.swift = {
    formatters = {
      {
        exe = "swiftformat",
        args = {},
        stdin = true,
      },
    },
    lsp = {
      path = "sourcekit-lsp",
    },
  }
end

M.format = function()
  O.formatters.filetype["swift"] = require("lv-utils").wrap_formatters(O.lang.swift.formatters)

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  -- TODO: implement linter (if applicable)
  return "No linter configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "sourcekit" then
    return
  end

  require("lspconfig").sourcekit.setup {
    cmd = { "xcrun", O.lang.swift.lsp.path },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "swift" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
