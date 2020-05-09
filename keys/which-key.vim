" map leader to which_key
" call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :silent WhichKey ' '<CR>

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" highlight default link WhichKey          Function
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Keyword
" highlight default link WhichKeyDesc      Identifier

highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler 

