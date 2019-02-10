" Add the dein installation directory into runtimepath
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')
  
  " Themes
  call dein#add('liuchengxu/space-vim-dark')
  call dein#add('joshdick/onedark.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('jacoborus/tender.vim')
  " Better Syntax Support
  call dein#add('sheerun/vim-polyglot')
  " powerline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
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
