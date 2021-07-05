require("lspconfig").intelephense.setup {
  cmd = { DATA_PATH .. "/lspinstall/php/node_modules/.bin/intelephense", "--stdio" },
  on_attach = require("lsp").common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = O.lang.php.diagnostics.virtual_text,
      signs = O.lang.php.diagnostics.signs,
      underline = O.lang.php.diagnostics.underline,
      update_in_insert = true,
    }),
  },
  filetypes = O.lang.php.filetypes,
  settings = {
    intelephense = {
      format = {
        braces = O.lang.php.format.braces,
      },
      environment = {
        phpVersion = O.lang.php.environment.php_version,
      },
    },
  },
}
