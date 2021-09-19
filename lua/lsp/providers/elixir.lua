local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "elixirls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/elixir/elixir-ls/language_server.sh" },
    },
  },
}
return opts
