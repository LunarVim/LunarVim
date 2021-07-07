require "lsp.tsserver-ls"

if O.lang.javascript.efm.active == true then
  require("lsp.efm-ls").generic_setup({"javascript"})
end
vim.cmd "setl ts=2 sw=2"
