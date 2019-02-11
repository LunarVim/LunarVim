" Enable deoplete
let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
