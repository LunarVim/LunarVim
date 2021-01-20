" Basic Key Mappings

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l
" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

if exists('g:vscode')

  " Simulate same TAB behavior in VSCode
  " nmap <Tab> :Tabnext<CR>
  " nmap <S-Tab> :Tabprev<CR>

else

  " Better nav for omnicomplete
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")

  " I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  " Easy CAPS
  " inoremap <c-u> <ESC>viwUi
  " nnoremap <c-u> viwU<Esc>

  " TAB in general mode will move to text buffer
  nnoremap <silent> <Leader><Left> :BufferPrevious<CR>
  nnoremap <silent> <Leader><Up> :BufferMovePrevious<CR>
  " SHIFT-TAB will go back
  nnoremap <silent> <Leader><Right> :BufferNext<CR>
  nnoremap <silent> <Leader><Down> :BufferMoveNext<CR>

  " delete buffer with ctrl+w c to replicate behaviour of close

  " Move selected line / block of text in visual mode
  " shift + k to move up
  " shift + j to move down
  xnoremap K :move '<-2<CR>gv-gv
  xnoremap J :move '>+1<CR>gv-gv

  " Alternate way to save
  noremap <silent> <C-s> :w<CR>
  " Alternate way to quit
  nnoremap <silent> <C-q> :BufferClose<CR>
  nnoremap <silent> <C-t> <C-w>T
  " Use control-c instead of escape
  noremap <silent> <C-c> <Esc>

  " <TAB>: completion.
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  " Better window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " Terminal window navigation
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>

  " Use alt + hjkl to resize windows
  nnoremap <silent> <M-j>    :resize -2<CR>
  nnoremap <silent> <M-k>    :resize +2<CR>
  nnoremap <silent> <M-h>    :vertical resize -2<CR>
  nnoremap <silent> <M-l>    :vertical resize +2<CR>

  " nnoremap <C-ü> :resize -2<CR>
  " nnoremap <C-ö> :resize +2<CR>
  " nnoremap <C-ä> :vertical resize -2<CR>
  " nnoremap <C-#> :vertical resize +2<CR>

  let g:elite_mode=0                      " Disable arrows"
  " Disable arrow movement, resize splits instead.
  if get(g:, 'elite_mode')
    nnoremap <C-ü> :resize -2<CR>
    nnoremap <C-ö> :resize +2<CR>
    nnoremap <C-ä> :vertical resize -2<CR>
    nnoremap <C-#> :vertical resize +2<CR>
  endif

  " create space on top and bottom
  nmap <silent> ü o<ESC>k
  nmap <silent> Ü O<ESC>j

  " jump between gaps
  nmap <silent> ö {zz
  nmap <silent> ä }zz

  " jump between methods
  nmap <silent> äö [mzz
  nmap <silent> öä ]mzz

  " jump between curly braces
  nmap <silent> Ö ?{<CR>:let @/ = ""<CR>zz
  nmap <silent> Ä /{<CR>:let @/ = ""<CR>zz

  " run through function parantheses
  nmap <silent> + /)<CR>:let @/ = ""<CR>zz
  nmap <silent> * ?)<CR>:let @/ = ""<CR>zz
  nmap <silent> # /(<CR>:let @/ = ""<CR>zz
  nmap <silent> ' ?(<CR>:let @/ = ""<CR>zz

  " copy last register
  nmap <silent> pü diw"*P

  " copy paste from system clipboard only
  noremap  p "*p
  noremap  P "*P
  vnoremap p "*p
  vnoremap P "*P

  " x to blackhole
  noremap  x "_x
  vnoremap x "_x

  " c to blackhole
  noremap  c "_c
  vnoremap c "_c
endif

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
