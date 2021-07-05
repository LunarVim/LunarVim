-- npm install -g vscode-json-languageserver
require("lspconfig").jsonls.setup {
  cmd = {
    "node",
    DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
    "--stdio",
  },
  on_attach = require("lsp").common_on_attach,

}

require("lsp.ts-fmt-lint").setup()

if O.lang.json.autoformat then
  require("lv-utils").define_augroups {
    _json_format = {
      {
        "BufWritePre",
        "*.json",
        "lua vim.lsp.buf.formatting_seq_sync(nil, 1000)",
      },
    },
  }
end
