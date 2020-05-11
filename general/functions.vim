" Turn spellcheck on for markdown files
augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

" Remove trailing whitespaces automatically before save
" augroup strip_ws
"   autocmd BufWritePre * call utils#stripTrailingWhitespaces()
" augroup END
