" Random Useful Functions

" Turn spellcheck on for markdown files
augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

" function! OpenLiveServer()
"  echo 'live server is on'
"  silent !live-server % &
" endfunction

command Serve :call OpenLiveServer()
nnoremap <silent>bs :call OpenLiveServer()<CR>

" augroup strip_ws
"   autocmd BufWritePre * call utils#stripTrailingWhitespaces()
" augroup END
