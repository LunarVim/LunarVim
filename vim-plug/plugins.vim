" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  Plug 'suy/vim-context-commentstring'
  " Change dates fast
  Plug 'tpope/vim-speeddating'
  " Convert binary, hex, etc..
  Plug 'glts/vim-radical'
  " Files
  Plug 'tpope/vim-eunuch'
  " Repeat stuff
  Plug 'tpope/vim-repeat'
  " Surround
  Plug 'tpope/vim-surround'
  " Better Comments
  Plug 'tpope/vim-commentary'
  " Have the file system follow you around
  Plug 'airblade/vim-rooter'
  " auto set indent settings
  Plug 'tpope/vim-sleuth'

  " Text Navigation
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'
  " Add some color
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'luochen1990/rainbow'
  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'
  " Cool Icons
  Plug 'ryanoasis/vim-devicons'
  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  " Closetags
  Plug 'alvan/vim-closetag'
  " Themes
  Plug 'christianchiarulli/onedark.vim'
  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Status Line
  Plug 'vim-airline/vim-airline'
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  " Terminal
  Plug 'voldikss/vim-floaterm'
  " Start Screen
  Plug 'mhinz/vim-startify'
  " Vista
  Plug 'liuchengxu/vista.vim'
  " See what keys do like in emacs
  Plug 'liuchengxu/vim-which-key'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'
  " Interactive code
  Plug 'metakirby5/codi.vim'
  " Debugging
  Plug 'puremourning/vimspector'
  " Better tabline
  Plug 'mg979/vim-xtabline'
  " undo time travel
  Plug 'mbbill/undotree'
  " highlight all matches under cursor
  Plug 'RRethy/vim-illuminate'
  " Find and replace
  Plug 'brooth/far.vim'
  " Auto change html tags
  Plug 'AndrewRadev/tagalong.vim'
  " live server
  Plug 'turbio/bracey.vim'
  " Smooth scroll
  Plug 'psliwka/vim-smoothie'
  " async tasks
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  " Swap windows
  Plug 'wesQ3/vim-windowswap'
  " Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
  " Easily Create Gists
  Plug 'mattn/vim-gist'
  Plug 'mattn/webapi-vim'

  " Plugin Graveyard

  " Better Whitespace
  " Plug 'ntpeters/vim-better-whitespace'
  " jsx syntax support
  " Plug 'maxmellon/vim-jsx-pretty'
  " Typescript syntax
  " Plug 'HerringtonDarkholme/yats.vim'
  " Multiple Cursors
  " Plug 'terryma/vim-multiple-cursors'
  " Async Linting Engine
  " TODO make sure to add ale config before plugin
  " Plug 'dense-analysis/ale'
  " Plug 'kaicataldo/material.vim'
  " Plug 'NLKNguyen/papercolor-theme'
  " Plug 'tomasiser/vim-code-dark'
  " Vim Wiki
  " Plug 'https://github.com/vimwiki/vimwiki.git'
  " Better Comments
  " Plug 'jbgutierrez/vim-better-comments'
  " Echo doc
  " Plug 'Shougo/echodoc.vim'
  " Plug 'hardcoreplayers/spaceline.vim'
  " Plug 'vim-airline/vim-airline-themes'
  " Ranger
  " Plug 'francoiscabrol/ranger.vim'
  " Plug 'rbgrouleff/bclose.vim'
  " Making stuff
  " Plug 'neomake/neomake'
  " Plug 'mhinz/vim-signify'
  " Plug 'easymotion/vim-easymotion'
  " Plug 'preservim/nerdcommenter'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
