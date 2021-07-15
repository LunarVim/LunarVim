-- TODO: what is a tailwindcss filetype
local lspconfig = require "lspconfig"

lspconfig.tailwindcss.setup {
  cmd = {
    "node",
    require("lsp.installer").get_langserver_path "terraform",
    "--stdio",
  },
  filetypes = O.lang.tailwindcss.filetypes,
  root_dir = require("lspconfig/util").root_pattern("tailwind.config.js", "postcss.config.ts", ".postcssrc"),
  on_attach = require("lsp").common_on_attach,
}
