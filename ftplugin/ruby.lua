require("core.formatter").setup "ruby"

require("lint").linters_by_ft = {
  ruby = O.lang.ruby.linters,
}

-- also support sorbet
require("lsp").setup(O.lang.ruby.lsp.provider, O.lang.ruby.lsp.setup)
