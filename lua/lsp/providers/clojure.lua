local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "clojure_lsp",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/clojure/clojure-lsp" },
    },
  },
}
return opts
