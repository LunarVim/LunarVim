
local lsp = require'lspconfig'
lsp.vuels.setup{
root_dir = lsp.util.root_pattern(".git",".")
}
