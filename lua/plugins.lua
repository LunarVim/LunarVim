return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    _builtin = require "core.lspinstall",
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "tjdevries/astronauta.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    _builtin = require "core.telescope",
  },

  -- Completion & Snippets
  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    wants = "vim-vsnip",
    requires = {
      {
        "hrsh7th/vim-vsnip",
        wants = "friendly-snippets",
        event = "InsertCharPre",
      },
      {
        "rafamadriz/friendly-snippets",
        event = "InsertCharPre",
      },
    },
    _builtin = require "core.compe",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = "nvim-compe",
    _builtin = require "core.autopairs",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    _builtin = require "core.treesitter",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    _builtin = require "core.nvimtree",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    _builtin = require "core.gitsigns",
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    event = "BufWinEnter",
    _builtin = require "core.which-key",
  },

  -- Comments
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    _builtin = require "core.comment",
  },

  -- vim-rooter
  {
    "airblade/vim-rooter",
    _builtin = require "core.rooter",
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status Line and Bufferline
  {
    "glepnir/galaxyline.nvim",
    event = "BufWinEnter",
    _builtin = require "core.galaxyline",
  },

  {
    "romgrk/barbar.nvim",
    event = "BufWinEnter",
    _builtin = require "core.bufferline",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    _builtin = require "core.dap",
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
  },

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    _builtin = require "core.dashboard",
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    _builtin = require "core.terminal",
  },
}
