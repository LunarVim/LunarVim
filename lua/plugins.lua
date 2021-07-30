return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      local lspinstall = require "lspinstall"
      lspinstall.setup()
      if lvim.builtin.lspinstall.on_config_done then
        lvim.builtin.lspinstall.on_config_done(lspinstall)
      end
    end,
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "tjdevries/astronauta.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
      if lvim.builtin.telescope.on_config_done then
        lvim.builtin.telescope.on_config_done(require "telescope")
      end
    end,
  },

  -- Completion & Snippets
  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("core.compe").setup()
      if lvim.builtin.compe.on_config_done then
        lvim.builtin.compe.on_config_done(require "compe")
      end
    end,
    -- wants = "vim-vsnip",
    -- requires = {
    -- {
    --   "hrsh7th/vim-vsnip",
    --   wants = "friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- {
    --   "rafamadriz/friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- },
  },
  {
    "hrsh7th/vim-vsnip",
    -- wants = "friendly-snippets",
    event = "InsertCharPre",
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = "nvim-compe",
    config = function()
      local autopairs = require("core.autopairs").setup()
      if lvim.builtin.autopairs.on_config_done then
        lvim.builtin.autopairs.on_config_done(autopairs)
      end
    end,
    disable = not lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("core.treesitter").setup()
      if lvim.builtin.treesitter.on_config_done then
        lvim.builtin.treesitter.on_config_done(require "nvim-treesitter.configs")
      end
    end,
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("core.nvimtree").setup()
      if lvim.builtin.nvimtree.on_config_done then
        lvim.builtin.nvimtree.on_config_done(require "nvim-tree.config")
      end
    end,
  },

  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("core.gitsigns").setup()
      if lvim.builtin.gitsigns.on_config_done then
        lvim.builtin.gitsigns.on_config_done(require "gitsigns")
      end
    end,
    event = "BufRead",
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("core.which-key").setup()
      if lvim.builtin.which_key.on_config_done then
        lvim.builtin.which_key.on_config_done(require "which-key")
      end
    end,
    event = "BufWinEnter",
  },

  -- Comments
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
      if lvim.builtin.comment.on_config_done then
        lvim.builtin.comment.on_config_done(nvim_comment)
      end
    end,
  },

  -- vim-rooter
  {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_silent_chdir = 1
      if lvim.builtin.rooter.on_config_done then
        lvim.builtin.rooter.on_config_done()
      end
    end,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status Line and Bufferline
  {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
      if lvim.builtin.galaxyline.on_config_done then
        lvim.builtin.galaxyline.on_config_done(require "galaxyline")
      end
    end,
    event = "BufWinEnter",
    disable = not lvim.builtin.galaxyline.active,
  },

  {
    "romgrk/barbar.nvim",
    config = function()
      require "core.bufferline"
      if lvim.builtin.bufferline.on_config_done then
        lvim.builtin.bufferline.on_config_done()
      end
    end,
    event = "BufWinEnter",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("core.dap").setup()
      if lvim.builtin.dap.on_config_done then
        lvim.builtin.dap.on_config_done(require "dap")
      end
    end,
    disable = not lvim.builtin.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not lvim.builtin.dap.active,
  },

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("core.dashboard").setup()
      if lvim.builtin.dashboard.on_config_done then
        lvim.builtin.dashboard.on_config_done(require "dashboard")
      end
    end,
    disable = not lvim.builtin.dashboard.active,
  },

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal").setup()
      if lvim.builtin.terminal.on_config_done then
        lvim.builtin.terminal.on_config_done(require "toggleterm")
      end
    end,
    disable = not lvim.builtin.terminal.active,
  },
}
