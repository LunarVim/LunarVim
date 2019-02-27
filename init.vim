" Activate Modules
source $HOME/.config/nvim/modules/pythonpath.vim
source $HOME/.config/nvim/modules/plugins.vim
source $HOME/.config/nvim/modules/general.vim
source $HOME/.config/nvim/modules/theme.vim
source $HOME/.config/nvim/modules/airline.vim
source $HOME/.config/nvim/modules/deoplete.vim
source $HOME/.config/nvim/modules/nerdtree.vim
source $HOME/.config/nvim/modules/startify.vim
source $HOME/.config/nvim/modules/gutentags_plus.vim
source $HOME/.config/nvim/modules/markdown-preview.vim
source $HOME/.config/nvim/modules/language_server.vim
source $HOME/.config/nvim/modules/ale.vim
source $HOME/.config/nvim/modules/goyo-limelight.vim
source $HOME/.config/nvim/modules/relativenums.vim
source $HOME/.config/nvim/modules/pydocstring.vim
source $HOME/.config/nvim/modules/neosnippets.vim
source $HOME/.config/nvim/modules/emmet.vim
source $HOME/.config/nvim/modules/colorizer.vim
source $HOME/.config/nvim/modules/rainbow.vim
source $HOME/.config/nvim/modules/vim-which-key.vim
source $HOME/.config/nvim/modules/echodoc.vim
" Special test file "
source $HOME/.config/nvim/modules/test.vim

set conceallevel=0
"TODO"
"change install script to install pyls in base and clone base instead"
"npm i -g bash-language-server
"npm install -g javascript-typescript-langserver
"fix ctrl+l in python
" fixed use :map to see what things are mapped to if behavior is wonky
"install ripgrep" for gutentags to ignore .gitignore
"install universal ctags"
" TODO add this to script npm i -g bash-language-server
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
