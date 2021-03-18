-- npm install -g vim-language-server
require'lspconfig'.vimls.setup {on_attach = require'lsp'.common_on_attach}
