local M = {}

local formatter_profiles = {
  dart = {
    exe = "dart",
    args = { "format" },
    stdin = true,
  },
}

M.config = function()
  O.lang.dart = {
    sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    formatters = {
      "dart",
    },
  }
end

M.format = function()
  O.formatters.filetype["dart"] = require("lv-utils").wrap_formatters(O.lang.dart.formatters, formatter_profiles)

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
  if require("lv-utils").check_lsp_client_active "dartls" then
    return
  end

  require("lspconfig").dartls.setup {
    cmd = { "dart", O.lang.dart.sdk_path, "--lsp" },
    on_attach = require("lsp").common_on_attach,
    init_options = {
      closingLabels = false,
      flutterOutline = false,
      onlyAnalyzeProjectsWithOpenFiles = false,
      outline = false,
      suggestFromUnimportedLibraries = true,
    },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
