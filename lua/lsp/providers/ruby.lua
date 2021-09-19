local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "solargraph",
    setup = {
      cmd = {
        lvim.lsp.ls_install_prefix .. "/ruby/solargraph/solargraph",
        "stdio",
      },
      filetypes = { "ruby" },
      init_options = {
        formatting = true,
      },
      root_dir = function(fname)
        local util = require("lspconfig").util
        return util.root_pattern("Gemfile", ".git")(fname)
      end,
      settings = {
        solargraph = {
          diagnostics = true,
        },
      },
    },
  },
}
return opts
