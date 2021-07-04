require'lspconfig'.dartls.setup{
    cmd = { "dart", O.lang.dart.sdk_path, "--lsp" },
    on_attach = require'lsp'.common_on_attach,
    init_options = {
      closingLabels = false,
      flutterOutline = false,
      onlyAnalyzeProjectsWithOpenFiles = false,
      outline = false,
      suggestFromUnimportedLibraries = true
    }
}

if O.lang.python.autoformat then
    require('lv-utils').define_augroups({
        _dart_autoformat = {
            {
                'BufWritePre', '*.dart',
                'lua vim.lsp.buf.formatting_sync(nil, 1000)'
            }
        }
    })
end
