local M = {}

M.config = function()
  O.lang.dart = {
    sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    formatter = {
      exe = "dart",
      args = { "format" },
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["dart"] = {
    function()
      return {
        exe = O.lang.dart.formatter.exe,
        args = O.lang.dart.formatter.args,
        stdin = O.lang.dart.formatter.stdin,
      }
    end,
  }

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
  if require("utils").check_lsp_client_active "dartls" then
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
