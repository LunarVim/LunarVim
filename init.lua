-- General mappings
require('plugins')
require('keymappings')
require('settings')
require('colorscheme')

-- Plugins
require('nv-colorizer')
require('nv-nvimtree')
require('nv-treesitter')
require('nv-galaxyline')
require('nv-barbar')
require('nv-gitsigns')
require('nv-nvim-autopairs')
require('nv-kommentary')
require('nv-quickscope')
require('nv-rnvimr')
require('nv-startify')
require('nv-telescope')
require('nv-floaterm')
require('nv-vim-rooter')
require('nv-lspkind')
require('nv-hop')
require('nv-compe')
require('nv-closetag')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/lua/nv-whichkey/init.vim')

-- LSP
require('lsp')
require('utils')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.js-ts-ls')

