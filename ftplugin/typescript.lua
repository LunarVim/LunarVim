require "lsp.tsserver-ls"

if O.lang.typescript.efm.active == true then
  require("lsp.efm-ls").generic_setup({"typescript"})
end
vim.cmd "setl ts=2 sw=2"
