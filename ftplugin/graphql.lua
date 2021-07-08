if require("lv-utils").check_lsp_client_active "graphql" then
  return
end

-- npm install -g graphql-language-service-cli
require("lspconfig").graphql.setup { on_attach = require("lsp").common_on_attach }
