local opts = {
  lsp = {
    active = false,
    provider = "tailwindcss",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/tailwindcss/node_modules/.bin/tailwindcss-language-server", "--stdio" },
    },
  },
}
return opts
