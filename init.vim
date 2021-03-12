"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" General Settings
if !exists('g:vscode')
  source ~/.config/nvim/plug-config/polyglot.vim
endif
source ~/.config/nvim/vim-plug/plugins.vim
source ~/.config/nvim/general/settings.vim
source ~/.config/nvim/general/functions.vim
source ~/.config/nvim/keys/mappings.vim

if exists('g:vscode')
  " VS Code extension
  source ~/.config/nvim/vscode/settings.vim
  source ~/.config/nvim/plug-config/easymotion.vim
  source ~/.config/nvim/plug-config/highlightyank.vim
else

  " Themes
  source ~/.config/nvim/themes/syntax.vim
  source ~/.config/nvim/themes/nvcode.vim

  " Plugin Configuration
  source ~/.config/nvim/keys/which-key.vim
  source ~/.config/nvim/plug-config/vim-commentary.vim
  source ~/.config/nvim/plug-config/rnvimr.vim
  source ~/.config/nvim/plug-config/codi.vim
  source ~/.config/nvim/plug-config/vim-wiki.vim
  source ~/.config/nvim/plug-config/easymotion.vim
  source ~/.config/nvim/plug-config/goyo.vim
  source ~/.config/nvim/plug-config/vim-rooter.vim
  source ~/.config/nvim/plug-config/start-screen.vim
  source ~/.config/nvim/plug-config/gitgutter.vim
  source ~/.config/nvim/plug-config/git-messenger.vim
  source ~/.config/nvim/plug-config/closetags.vim
  source ~/.config/nvim/plug-config/floaterm.vim
  source ~/.config/nvim/plug-config/barbar.vim
  source ~/.config/nvim/plug-config/far.vim
  source ~/.config/nvim/plug-config/tagalong.vim
  source ~/.config/nvim/plug-config/bracey.vim
  source ~/.config/nvim/plug-config/markdown-preview.vim
  source ~/.config/nvim/plug-config/nvimtree-config.vim
  source ~/.config/nvim/plug-config/lsp-saga.vim
  source ~/.config/nvim/plug-config/lightbulb.vim
  source ~/.config/nvim/lua/lsp-wrapper.vim
  source ~/.config/nvim/plug-config/lsp-config.vim
  luafile ~/.config/nvim/lua/lsp/general-ls.lua
  luafile ~/.config/nvim/lua/plugins/galaxyline-config.lua
  luafile ~/.config/nvim/lua/plugins/nvimtree-config.lua
  luafile ~/.config/nvim/lua/plugins/treesitter-config.lua
  luafile ~/.config/nvim/lua/plugins/colorizer-config.lua
  luafile ~/.config/nvim/lua/plugins/telescope-config.lua
  luafile ~/.config/nvim/lua/lsp/lsp-kind.lua
  luafile ~/.config/nvim/lua/plugins/compe-config.lua
  luafile ~/.config/nvim/lua/plugins/lspsaga-config.lua
  " LSP: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  luafile ~/.config/nvim/lua/lsp/lsp-config.lua
  luafile ~/.config/nvim/lua/lsp/lua-ls.lua
  luafile ~/.config/nvim/lua/lsp/python-ls.lua
  luafile ~/.config/nvim/lua/lsp/bash-ls.lua
  luafile ~/.config/nvim/lua/lsp/css-ls.lua
  luafile ~/.config/nvim/lua/lsp/docker-ls.lua
  luafile ~/.config/nvim/lua/lsp/graphql-ls.lua
  luafile ~/.config/nvim/lua/lsp/html-ls.lua
  luafile ~/.config/nvim/lua/lsp/javascript-ls.lua
  luafile ~/.config/nvim/lua/lsp/json-ls.lua
  luafile ~/.config/nvim/lua/lsp/vim-ls.lua
  luafile ~/.config/nvim/lua/lsp/yaml-ls.lua
endif
source $HOME/.config/nvim/plug-config/quickscope.vim

" Add paths to node and python here
if !empty(glob("~/.config/nvim/paths.vim"))
  source $HOME/.config/nvim/paths.vim
endif

  " TODO
  " snippets
  " autoimport jsx
  " https://github.com/mfussenegger/nvim-jdtls
  " fix space and tab triggering completion all the time
  " Provide diagnostics for nvim tree 
  " port everything possible to lua
