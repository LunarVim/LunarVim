" set which key
"
" Any keymapping that involves <leader is here>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
let g:which_key_sep = '→'

" By default timeoutlen is 1000 ms
set timeoutlen=100

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

let g:which_key_map =  {}
"let g:which_key_default_group_name = ''
"let g:which_key_map.f = { 'name' : '+file' }
"nnoremap <silent> <leader>fs :update<CR>
"let g:which_key_map.f.s = ['update', 'save-file']

" This is a funtion to open any file with <leader>(key sequence)
fun! OpenConfigFile(file)
  if (&filetype ==? 'startify')
    execute 'e ' . a:file
  else
    execute 'tabe ' . a:file
  endif
endfun

nnoremap <silent> <leader>in :call OpenConfigFile('~/.config/nvim/init.vim')<cr>
nnoremap <silent> <leader>bashrc :call OpenConfigFile('~/.bashrc')<cr>
nnoremap <silent> <leader>code :call OpenConfigFile('~/Library/Application Support/Code/User/settings.json')<cr>

let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle','commenter' ]
let g:which_key_map['p'] = [ 'pclose','close-preview' ]
let g:which_key_map['q'] = [ 'q','quit' ]
let g:which_key_map['s'] = [ 'w','save' ]
let g:which_key_map['f'] = [ 'Denite file','files' ]

let g:which_key_map.t = {
      \ 'name' : '+toggle' ,
      \ 'e' : ['NERDTreeToggle'    , 'file-explorer']           ,
      \ 'b' : ['TagbarToggle'      , 'tagbar']                  ,
      \ 'n' : ['set nonumber!'         , 'line-numbers']            ,
      \ 's' : [':nohlsearch'        , 'remove-search-highlight'] ,
      \ 'c' : ['ColorToggle'       , 'remove-color']            ,
      \ }

let g:which_key_map.h = {
      \ 'name' : '+highlights' ,
      \ 's' : ['nohlsearch'     , 'remove-search-highlight'] ,
      \ 'c' : ['ColorToggle'    , 'remove-color']            ,
      \ }
      "<Plug>(ale_hover)`
      "\ 'f' : ['LanguageClient#textDocument_formatting()'     , 'formatting']       ,
      "\ 'h' : ['LanguageClient#textDocument_hover()'          , 'hover']            ,
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ 'c' : ['LanguageClient_contextMenu()'                 , 'context_menu']     ,
      \ 'f' : ['ALEFix'                                       , 'formatting']       ,
      \ 'i' : ['ALEInfo'                                      , 'info']             ,
      \ 'h' : ['<Plug>(ale_hover)'                            , 'hover']            ,
      \ 'r' : ['LanguageClient#textDocument_references()'     , 'references']       ,
      \ 'R' : ['LanguageClient#textDocument_rename()'         , 'rename']           ,
      \ 's' : ['LanguageClient#textDocument_documentSymbol()' , 'document-symbol']  ,
      \ 'S' : ['LanguageClient#workspace_symbol()'            , 'workspace-symbol'] ,
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']       ,
        \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']  ,
        \ 'i' : ['LanguageClient#textDocument_implementation()'  , 'implementation']  ,
        \ },
      \ 'p' : {
        \ 'name': '+python',
        \ 'd' : ['<Plug>(pydocstring)'  , 'python-docstring']  ,
        \ },
      \ }

let g:which_key_map.w = {
      \ 'name' : '+windows' ,
      \ 'v' : ['<C-W>v'     , 'split-window-right']    ,
      \ 'h' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'o' : ['only'       , 'close-all-other-windows']    ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

let g:which_key_map.b = {
       \ 'name' : '+buffer' ,
       \ '1' : ['b1'        , 'buffer 1']        ,
       \ '2' : ['b2'        , 'buffer 2']        ,
       \ 'd' : ['bd'        , 'delete-buffer']   ,
       \ 'f' : ['bfirst'    , 'first-buffer']    ,
       \ 'l' : ['blast'     , 'last-buffer']     ,
       \ 'n' : ['bnext'     , 'next-buffer']     ,
       \ 'p' : ['bprevious' , 'previous-buffer'] ,
       \ '?' : ['Buffers'   , 'fzf-buffer']      ,
       \ 's' : ['Startify'  , 'Startify']     ,
       \ 'g' : ['Goyo'      , 'Goyo'] ,
       \ }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

""nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
""nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
