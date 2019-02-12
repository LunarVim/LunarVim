




  " Search Index shows how many instances of searched term
  call dein#add('google/vim-searchindex')
  "call dein#add('steffanc/cscopemaps.vim')
  "call dein#add('brookhong/cscope.vim')
  "call dein#add('vim-scripts/autoload_cscope.vim')
  " Add or remove your plugins here: TODO
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " Searchtasks searches for TODO, FIXME, XXX and such run :SearchTasks .  
  call dein#add('gilsondev/searchtasks.vim') 
  call dein#add('arakashic/chromatica.nvim') 
  " Multiple Cursors
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('scrooloose/nerdcommenter')
  " FZF
  call dein#add('junegunn/fzf.vim',  { 'dir': '~/.fzf', 'do': './install --all' })
  "call dein#add('junegunn/fzf')
  " For autocomplete
  call dein#add('zchee/deoplete-jedi')
  call dein#add('Shougo/deoplete.nvim')
  " For Web Development
  call dein#add('pangloss/vim-javascript')
  call dein#add('elzr/vim-json')
  call dein#add('mxw/vim-jsx')
  call dein#add('mattn/emmet-vim')
  call dein#add('prettier/vim-prettier', {'do': 'yarn install'})
  " Auto flow
  call dein#add('wokalski/autocomplete-flow') 
  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

" NeoSnippet
let g:neosnippet#enable_completed_snippet = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let NERDTreeShowHidden = 1

" MULTI CURSOR
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" ALE
" Note pylint sucks
" Note for javascript you need to:
" npm install eslint --save-dev
" ./node_modules/.bin/eslint --init
" or for global
" npm install -g eslint
" eslint --init
let g:ale_linters = {
    \ 'cpp' : ['gcc'],
    \ 'c' : ['gcc'],
    \ 'vim' : ['vint'],
    \ 'python': ['flake8', 'pyre', 'vulture', 'prospector', 'pyflakes', 'mypy', 'pyls'],
    \ 'javascript': ['eslint']
    \}

"let g:LanguageClient_serverCommands = {
"    \ 'javascript': ['flow-language-server', '--stdio'],
"    \ }

let g:ale_cpp_gcc_options='-Wall -Wextra'
let g:ale_c_gcc_options='-Wall -Wextra'
let g:ale_vim_vint_executable = 'vint'
let g:ale_vim_vint_show_style_issues = 1
map <leader>a :ALEToggle<CR>

if !empty(glob("/usr/lib/rpm/redhat"))
    " For RHEL
    "let g:chromatica#libclang_path='/usr/lib64/llvm'
    let g:python3_host_prog = 'home/$USER/.conda/envs/py37/bin/python3.6'
    "let g:chromatica#enable_at_startup=1
    "let g:chromatica#responsive_mode=1
else
    " For Debian based   
    let g:chromatica#libclang_path='/usr/lib/llvm-6.0/lib'
    let g:python3_host_prog = '/usr/bin/python3.6'
    let g:chromatica#enable_at_startup=1
    let g:chromatica#responsive_mode=1
endif
" Chromatica
" FZF
if !empty((glob("~/.fzf")))
    set rtp+=~/.fzf
endif
""""""""""" FUNCTION KEYS """"""""""""""
"TODO figure out cscope
"TODO figure out virtualenv for neovim
"TODO Split vim into ftp stuff rtp


