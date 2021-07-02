require('default-config')
vim.cmd('luafile ' .. CONFIG_PATH .. '/lv-config.lua')
require('settings')
require('plugins')
require('colorscheme')
require('lv-utils')
require('keymappings')
require('lv-galaxyline')
require('lv-treesitter')
require('lv-which-key')
require('lsp')
if O.lang.emmet.active then require('lsp.emmet-ls') end
if O.lang.deno.active then require('lsp.deno-ls') end
