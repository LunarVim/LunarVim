" this function check whether vim is in normal mode or not and comment appropriately
function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else    
    execute "'<,'>Commentary"
  endif
 endfunction
vnoremap <silent> <space>/ :call Comment()  
autocmd filetype javascript.jsx setlocal commentstring={/*\ %s\ */}
