lvim.leader = ";"
lvim.colorscheme = "gruvbox"

lvim.plugins = {
  { "ellisonleao/gruvbox.nvim" },
  { "norcalli/nvim-colorizer.lua" }
}

lvim.transparent_window = true

require 'colorizer'.setup()
