-- If you are using rvm, make sure to change below configuration
require'lspconfig'.solargraph.setup {
    cmd = { DATA_PATH .. "~/.rbenv/shims/solargraph", "--stdio" },
    on_attach = require'lsp'.common_on_attach
}
