function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else
    execute "'<,'>Commentary"
  endif
 endfunction
noremap <silent> <C-\> :call Comment()<CR>
