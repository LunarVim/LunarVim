"    ____      _ __        _         
"   /  _/___  (_) /__   __(_)___ ___ 
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/ 


" Always source these
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/general/paths.vim
source $HOME/.config/nvim/plug-config/easymotion.vim
source $HOME/.config/nvim/plug-config/quickscope.vim

" Source depending on if VSCode is our client
if exists('g:vscode')
    " VSCode extension
    source $HOME/.config/nvim/vscode/windows.vim
else
    " ordinary neovim
    source $HOME/.config/nvim/themes/syntax.vim
    source $HOME/.config/nvim/themes/onedark.vim
    source $HOME/.config/nvim/themes/airline.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/commentary.vim
    source $HOME/.config/nvim/plug-config/rainbow.vim
    lua require'plug-colorizer'
    source $HOME/.config/nvim/plug-config/coc.vim
endif
