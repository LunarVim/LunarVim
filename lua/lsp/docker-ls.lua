-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup {on_attach = require'lsp'.common_on_attach}
