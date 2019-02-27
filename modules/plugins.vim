" Add the dein installation directory into runtimepath
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

function! DoRemote()
    UpdateRemotePlugins
endfunction

if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  
  " All the Themes
  ""call dein#add('flazz/vim-colorschemes')
  call dein#add('liuchengxu/space-vim-dark')
  call dein#add('tomasiser/vim-code-dark')
  call dein#add('joshdick/onedark.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('jacoborus/tender.vim')
  call dein#add('luochen1990/rainbow')
  " key menu popup "
  call dein#add('liuchengxu/vim-which-key')
  "Interface"
  call dein#add('Shougo/denite.nvim')
  "  Neoterm
  call dein#add('kassio/neoterm')
  " Running tests in vim "
  call dein#add('janko-m/vim-test')
  " Better Syntax Support
  call dein#add('sheerun/vim-polyglot')
  " powerline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  " File manager
  call dein#add('scrooloose/NERDTree')
  " Comments "
  call dein#add('scrooloose/nerdcommenter')
  " Icons
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
  " Start Screen
  call dein#add('mhinz/vim-startify')
  " For ctags
  call dein#add('ludovicchabant/vim-gutentags')
  call dein#add('skywind3000/gutentags_plus')
  " Better Previews "
  call dein#add('skywind3000/vim-preview')
  " Tagbar
  call dein#add('majutsushi/tagbar')
  " Auto Pairs
  call dein#add('jiangmiao/auto-pairs')
  " Buffergator use \b
""  call dein#add('jeetsukumaran/vim-buffergator')
  " Ctrlp 
  call dein#add('ctrlpvim/ctrlp.vim')
  "Linting 
  call dein#add('w0rp/ale') 
  call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
  " Fuzzy finder
  call dein#add('junegunn/fzf.vim',  { 'dir': '~/.fzf', 'do': './install --all' })
  call dein#add('junegunn/fzf')
  " Sneak mode "
  call dein#add('justinmk/vim-sneak')
  ""Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  " BufOnly use :BufOnly to unload all or pass it a single buffer
  call dein#add('vim-scripts/BufOnly.vim')
  " Distraction free writing "
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')
  "Markdown viewer TODO Fix this stupid thing
  call dein#add('iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  })
""  call dein#add('iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }})
""  call dein#add('euclio/vim-markdown-composer')
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'})
  call dein#add('Shougo/neoinclude.vim')
  " Snippets "
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('mattn/emmet-vim')
  "echo doc 
  call dein#add('Shougo/echodoc.vim')
  "Colorizer "
  call dein#add('chrisbra/Colorizer')
  " Python docstring "
  call dein#add('heavenshell/vim-pydocstring')
  
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


" TODO inside dein/repos/ somewhere there are cach and state files which keep
" screwing me for installing new plugins
