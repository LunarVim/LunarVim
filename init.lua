if vim.g.vscode then
  vim.cmd('source ~/.config/nvim/lua/nv-vscode/init.vim')
else
  -- General mappings
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
  require('nv-barbar')
  require('nv-gitsigns')
  require('nv-nvim-autopairs')
  require('nv-neogit')
  require('nv-kommentary')
  require('nv-quickscope')
  require('nv-rnvimr')
  require('nv-startify')
  require('nv-telescope')
  require('nv-floaterm')
  require('nv-vim-rooter')
  require('nv-closetag')
  require('nv-lspkind')
  require('nv-hop')
  require('nv-gitblame')

  -- Which Key (Hope to replace with Lua plugin someday)
  vim.cmd('source ~/.config/nvim/lua/nv-whichkey/init.vim')

  -- LSP
  require('lsp')
  require('utils')
  require('lsp.lua-ls')
  require('lsp.bash-ls')
  require('lsp.js-ts-ls')
  -- require('lsp.java-ls')
  require('lsp.python-ls')
  require('lsp.json-ls')
  require('lsp.yaml-ls')
end
