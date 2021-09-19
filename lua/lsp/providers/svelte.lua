local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "svelte",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/svelte/node_modules/.bin/svelteserver", "--stdio" },
    },
  },
}
return opts
