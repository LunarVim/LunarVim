" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  " Text Navigation
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'
  " Change dates fast
  Plug 'tpope/vim-speeddating'

  if !exists('g:vscode')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{' 
    Plug 'jiangmiao/auto-pairs'
    " Themes
    Plug 'christianchiarulli/onedark.vim'
    " Plug 'kaicataldo/material.vim'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Status Line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    " Better Comments
    Plug 'tpope/vim-commentary'
    " Add some color
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'
    " Git
    Plug 'airblade/vim-gitgutter'
    " Terminal
    Plug 'voldikss/vim-floaterm'
    " Start Screen
    Plug 'mhinz/vim-startify'
    " Surround
    Plug 'tpope/vim-surround'
    " Vista
    Plug 'liuchengxu/vista.vim'
    " 
  endif


call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
