require("core.formatter").setup "lua"

require("lsp").setup(O.lang.lua.lsp)

require("lint").linters_by_ft = {
  lua = O.lang.lua.linters,
}
