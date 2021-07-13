-- Since lspinstall doesn't support Julia yet,
-- detect *jl files & trigger LanguageServer.jl
-- and add settings that make writing Julia nice
vim.cmd([[
  au BufRead,BufNewFile *.jl set filetype=julia
  let g:latex_to_unicode_auto = 1
  let g:latex_to_unicode_tab = 1
  autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
]])
