if require("lv-utils").check_lsp_client_active "dartls" then
  return
end

if O.lang.dart.flutter_tools.active then
  return
end

local util = require 'lspconfig/util'
require("lspconfig").dartls.setup {
  cmd = { "dart", O.lang.dart.sdk_path, "--lsp" },
  on_attach = require("lsp").common_on_attach,
  root_dir = function(fname)
    return util.root_pattern("pubspec.yaml", "*.iml", ".idea")(fname) or util.path.dirname(fname)
  end;
  init_options = {
  closingLabels = false,
  flutterOutline = false,
  onlyAnalyzeProjectsWithOpenFiles = false,
  outline = false,
  suggestFromUnimportedLibraries = true,
  },
}
