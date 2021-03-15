require('plugins')
require('keymappings')
require('settings')
require('colorscheme')

-- Plugins
require('nv-compe')
require('nv-colorizer')
require('nv-nvimtree')
require('nv-treesitter')
require('nv-galaxyline')
require('nv-bufferline')
require('nv-gitsigns')
require('nv-nvim-autopairs')
require('nv-kommentary')
require('nv-quickscope')
require('nv-rnvimr')
require('nv-startify')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/lua/nv-whichkey/init.vim')

-- LSP
require('lsp')
require('utils')
require('lsp.lua-ls')

