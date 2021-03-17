function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else    
    execute "'<,'>Commentary"
  endif
 endfunction
vnoremap <silent> <space>/ :call Comment()
"autocmd! BufRead,BufNewFile *.{jsx,jx,js} setlocal filetype=javascript.jsx
autocmd FileType javascriptreact setlocal commentstring={/*\ %s\ */}

