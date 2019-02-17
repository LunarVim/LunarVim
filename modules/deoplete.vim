" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "omnifunc"
let g:deoplete#auto_complete_delay = 0
""let g:deoplete#max_menu_width = 10
" let g:deoplete#ignore_sources = ['buffer']
"
" Close previews immediately
    autocmd CompleteDone * silent! pclose!
"
"better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

"<TAB>: completion.
""inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"use TAB as the mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ?  "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort ""     
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction ""   
inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


call deoplete#custom#option('sources', {
  \ 'python': ['file', 'LanguageClient', 'neosnippet'],
  \ })
" Sort matches alphabetically
call deoplete#custom#source('_', 'sorters', ['sorter_word'])
" Disable shorter or equal length matches
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
