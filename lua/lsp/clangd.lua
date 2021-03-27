require'lspconfig'.clangd.setup{
    cmd = {DATA_PATH .. "/lspinstall/clangd/clangd_11.0.0/bin/clangd"},
    on_attach = require'lsp'.common_on_attach
}
