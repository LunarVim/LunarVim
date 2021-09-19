local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "cssls",
    setup = {
      cmd = {
        "node",
        lvim.lsp.ls_install_prefix .. "/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio",
      },
    },
  },
}
return opts
