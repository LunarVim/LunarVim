-- npm i -g bash-language-server
require'lspconfig'.bashls.setup {on_attach = require'lsp'.common_on_attach}
