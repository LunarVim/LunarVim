O.formatters.filetype["dart"] = {
  function()
    return {
      exe = O.lang.dart.formatter.exe,
      args = O.lang.dart.formatter.args,
      stdin = not (O.lang.dart.formatter.stdin ~= nil),
    }
  end,
}

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}
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
