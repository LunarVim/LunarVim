
"""""""""" HOUSEKEEPING """"""""""
syntax on
set nowrap
set encoding=utf8
set mouse=a
set splitbelow
set splitright
set t_Co=256
set autochdir
" saving
nnoremap <C-s> :w<CR>
nnoremap <C-Q> :wq!<CR>
" escape can blow me
nnoremap <C-c> <Esc>
" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
" Always display the status line
set laststatus=2
" Gets rid of highlights after search
nnoremap <silent> <F7> :nohlsearch<CR><F7>
" Line numbers
set number
" Toggle line numbers
nnoremap <F6> :set nonumber!<CR>
nnoremap <F9> :vsplit<CR>
nnoremap <F10> :split<CR>
nnoremap <F12> :only<CR>
nnoremap <F2> :BuffergatorToggle<CR>
nnoremap <F3> :Files<CR>
nnoremap <F1> :10split term://bash<CR> 

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Be iMproved
if &compatible
  set nocompatible
endif

" Remap window switch
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Remap terminal switch
tnoremap <C-[> <C-\><C-n>
tnoremap <C-c><Esc> <Esc>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1
" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize -2<CR>
	nnoremap <Down>  :resize +2<CR>
	nnoremap <Left>  :vertical resize -2<CR>
	nnoremap <Right> :vertical resize +2<CR>
endif
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
let mapleader = ","
"""""""""" END HOUSEKEEPING """"""""""

"""""""""" PLUGINS """"""""""
" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/chris/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Start Screen
  call dein#add('mhinz/vim-startify')
  " Search Index shows how many instances of searched term
  call dein#add('google/vim-searchindex')
  " line indents
  "call dein#add('Yggdroot/indentLine')
  " Gutentags
  call dein#add('ludovicchabant/vim-gutentags')
  "call dein#add('steffanc/cscopemaps.vim')
  "call dein#add('brookhong/cscope.vim')
  "call dein#add('vim-scripts/autoload_cscope.vim')
  " Tagbar
  call dein#add('majutsushi/tagbar')
  " Add or remove your plugins here: TODO
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " Themes
  call dein#add('liuchengxu/space-vim-dark')
  call dein#add('nightsense/stellarized')
  call dein#add('vim-airline/vim-airline')
  "call dein#add('itchyny/lightline.vim')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('chriskempson/base16-vim')
  " Auto Pairs
  call dein#add('jiangmiao/auto-pairs')
    " Buffergator use \b
  call dein#add('jeetsukumaran/vim-buffergator')
  " Ctrlp 
  call dein#add('ctrlpvim/ctrlp.vim')
  " Searchtasks searches for TODO, FIXME, XXX and such run :SearchTasks .  
  call dein#add('gilsondev/searchtasks.vim') 
  "Syntax 
  call dein#add('w0rp/ale') 
  call dein#add('arakashic/chromatica.nvim') 
  "Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  " Multiple Cursors
  call dein#add('terryma/vim-multiple-cursors')
  " NERDTree
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/nerdcommenter')
  " FZF
  call dein#add('junegunn/fzf.vim',  { 'dir': '~/.fzf', 'do': './install --all' })
  "call dein#add('junegunn/fzf')
  " BufOnly use :BufOnly to unload all or pass it a single buffer
  call dein#add('vim-scripts/BufOnly.vim')
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
    " For vim 8+
    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"""""""""" END PLUGINS """"""""""

"""""""""" SPACEVIM THEME """"""""""

" Set theme TODO kill this light theme
if strftime('%H') >= 7 && strftime('%H') < 7
  set background=light
  colorscheme stellarized
else
  set background=dark
  colorscheme space-vim-dark

  " Range:   233 (darkest) ~ 238 (lightest)
  " Default: 235
  let g:space_vim_dark_background = 233
  color space-vim-dark
  hi Comment guifg=#5C6370 ctermfg=59
  let base16colorspace=256  " Access colors present in 256 colorspace
  if !empty(glob("/usr/lib/rpm/redhat"))
    "Lightline
    if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''

  " old vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

    "let g:loaded_airline = 1
    "set showtabline=2
    "set noshowmode
    "let g:lightline = {
    "  \ 'colorscheme': 'jellybeans',
    "  \ 'active': {
    "  \   'left': [['mode', 'paste'],
    "  \           ['gitbranch', 'readonly', 'filename', 'modified'] ]
    "  \ },
    "  \ 'component_function': {
    "  \   'gitbranch': 'fugitive#head'
    " \ },
    "  \ }
  else

    "Airline
    set noshowmode
    let g:airline_theme='violet'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1 
    let g:hybrid_custom_term_colors = 1
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
      let g:airline_symbols.space = "\ua0"
    endif
  endif
endif
" Enable highlighting of the current line
set cursorline
"""""""""" END THEME """"""""""

"""""""""" BEGIN CONFIGS """"""""""

" Deoplete
let g:deoplete#enable_at_startup = 1
" NeoSnippet
let g:neosnippet#enable_completed_snippet = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" Startify
let g:startify_custom_header = [                                                                                                                                                                                 
	\ '     _   __                _         ',
	\ '    / | / /__  ____ _   __(_)___ ___ ',
	\ '   /  |/ / _ \/ __ \ | / / / __ `__ \',
	\ '  / /|  /  __/ /_/ / |/ / / / / / / /',
	\ ' /_/ |_/\___/\____/|___/_/_/ /_/ /_/ ']

" Tagbar
nmap <F8> :TagbarToggle<CR>
" NERDTree
nmap <F5> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
" SearchTasks
nmap <F4> :SearchTasks *<CR>
"""""""""" END CONFIGS """"""""""

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

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
let g:ale_linters = {
    \ 'cpp' : ['gcc'],
    \ 'c' : ['gcc'],
    \ 'vim' : ['vint'],
    \ 'python': ['flake8', 'pyre', 'vulture', 'prospector', 'pyflakes', 'mypy', 'pyls']
    \}
let g:ale_cpp_gcc_options='-Wall -Wextra'
let g:ale_c_gcc_options='-Wall -Wextra'
let g:ale_vim_vint_executable = 'vint'
let g:ale_vim_vint_show_style_issues = 1
map <leader>a :ALEToggle<CR>

" Python TODO change this to point to virtual env with nevim support
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
"TODO create function key section
"TODO figure out virtualenv for neovim


