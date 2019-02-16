function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

nnoremap <leader>rn :call NumberToggle()<cr>
