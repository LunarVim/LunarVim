require('default-config')
vim.cmd('luafile ' .. CONFIG_PATH .. '/lv-config.lua')
require('settings')
require('plugins')
vim.g.colors_name = O.colorscheme
vim.g.syntax = true
require('lv-utils')
require('keymappings')
require('lv-galaxyline')
require('lv-treesitter')
require('lv-which-key')
require('lsp')
if O.lang.emmet.active then require('lsp.emmet-ls') end
require('lv-flutter-tools')
