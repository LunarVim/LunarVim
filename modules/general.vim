" Be IMproved
if &compatible
  set nocompatible
endif

" set leader key
let g:mapleader="\\"
" alias for leader key
nmap <space> \
xmap <space> \

syntax enable                           " Enables syntax highlighing
set hidden                              " Required for specific actions that require multiple buffers
set nowrap                              " display long lines as just one line
set encoding=utf-8                      " The encoding displayed 
set fileencoding=utf-8                  " The encoding written to file
set ruler              					" show the cursor position all the time
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set autochdir                           " Your working directory will always be the same as your working directory
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like

let g:python_highlight_all = 0          " Get rid of annoying red highlights"
let g:elite_mode=1                      " Disable arrows"

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize -2<CR>
    nnoremap <Down>  :resize +2<CR>
    nnoremap <Left>  :vertical resize -2<CR>
    nnoremap <Right> :vertical resize +2<CR>
endif

" Gives vim abilty to recognize filetypes
filetype plugin indent on                 
" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Open terminal with F1
nnoremap <silent> <F1> :10split term://bash<CR>
nnoremap <silent> <F2> :bdelete! term://*<return>
" insert mode for terminal
""autocmd BufWinEnter,WinEnter term://* startinsert
""autocmd BufLeave term://* stopinsert
" Toggle tagbar
"nnoremap <silent> <F2> :TagbarToggle<CR>
" Toggle Line numbers
"nnoremap <silent> <F4> :set nonumber!<CR>
" Toggle NERDTree
"nnoremap <silent> <F5> :NERDTreeToggle<CR>
" Startify
"nnoremap <silent> <F6> :Startify<CR>
" Get rid of highlights after search
"nnoremap <silent> <F7> :nohlsearch<CR><F7>
" Toggle open buffers
" nnoremap <silent> <F8> :BuffergatorToggle<CR>
" For fuzzy finder
""nnoremap <silent> <F9> :Files<CR>
" F10 split vertical
"nnoremap <silent> <F9> :vsplit<CR>
" F11 split horizontal
"nnoremap <silent> <F10> :split<CR>
" Make current buffer only buffer
"nnoremap <silent> <F12> :only<CR>
" Remap window switch
" Switch to rename for LSP to do add leader
""nnoremap <F4> :SearchTasks *<CR>

nnoremap <silent> <leader>q :q<return>
nnoremap <silent> <leader>n :NERDTreeToggle<return>
nnoremap <silent> <leader>m :TagbarToggle<return>
nnoremap <silent> <leader>l :set nonumber!<return>
nnoremap <silent> <leader>o :only<return>
nnoremap <silent> <leader>s :Startify<return>
nnoremap <silent> <leader>w :w<return>
nnoremap <silent> <leader>p :pclose<return>
nnoremap <silent> <leader>b :BuffergatorToggle<return>
nnoremap <silent> <leader>gy :Goyo<return>
nnoremap <silent> <leader>hi :nohlsearch<return>
nnoremap <silent> <leader>hs :split<return>
nnoremap <silent> <leader>vs :vsplit<return>
nnoremap <silent> <leader>gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>gr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>gc :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <leader>fr :call LanguageClient_textDocument_references()<CR>

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
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>


