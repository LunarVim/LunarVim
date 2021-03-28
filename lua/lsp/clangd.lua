require'lspconfig'.clangd.setup{
    cmd = {DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd"},
    on_attach = require'lsp'.common_on_attach
}
