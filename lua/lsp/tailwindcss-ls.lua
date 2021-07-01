local lspconfig = require 'lspconfig'

lspconfig.tailwindcss.setup {
    cmd = {
        "node", DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense/extension/dist/server/tailwindServer.js",
        "--stdio"
    },
    on_attach = require'lsp'.common_on_attach
}
