local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "html",
    setup = {
      cmd = {
        "node",
        lvim.lsp.ls_install_prefix .. "/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
        "--stdio",
      },
    },
  },
}
return opts
