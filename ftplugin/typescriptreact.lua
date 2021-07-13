if O.lang.tsserver.active then
  require "lsp.tsserver-ls"
elseif O.lang.deno.active then
  require "lsp.deno-ls"
end


vim.cmd "setl ts=2 sw=2"
