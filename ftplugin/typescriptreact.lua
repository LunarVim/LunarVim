require "lsp.tsserver-ls"

if O.lang.typescriptreact.efm.active == true then
  require("lsp.efm-ls").generic_setup({"typescriptreact"})
end
vim.cmd "setl ts=2 sw=2"
