-- TODO: what is a svelte filetype
require("lspconfig").svelte.setup {
  cmd = { require("lsp.installer").get_langserver_path "svelte", "--stdio" },
  on_attach = require("lsp").common_on_attach,
}
