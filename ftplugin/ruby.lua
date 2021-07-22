require("core.formatter").setup "ruby"

require("lint").linters_by_ft = {
  ruby = O.lang.ruby.linters,
}

-- also support sorbet
require("lsp").setup("solargraph", {
  O.lang.ruby.lsp.path,
  "stdio",
})
