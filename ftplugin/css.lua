-- npm install -g vscode-css-languageserver-bin
require("lspconfig").cssls.setup {
  cmd = {
    "node",
    DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
    "--stdio",
  },
  on_attach = require("lsp").common_on_attach,
}

require("lsp.ts-fmt-lint").setup()

if O.lang.css.autoformat then
  require("lv-utils").define_augroups {
    _css_format = {
      {
        "BufWritePre",
        "*.css",
        "lua vim.lsp.buf.formatting_seq_sync(nil, 1000)",
      },
    },
  }
end

vim.cmd "setl ts=2 sw=2"
