return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },

  -- TODO: refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
  { "neovim/nvim-lspconfig" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require("lspinstall").setup()
    end,
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "tjdevries/astronauta.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = [[require('core.telescope').setup()]],
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-compe",
    -- event = "InsertEnter",
    config = function()
      require("core.compe").setup()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require "core.autopairs"
    end,
  },

  -- Snippets

  { "hrsh7th/vim-vsnip", event = "InsertEnter" },
  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("core.treesitter").setup()
    end,
  },

  -- Formatter.nvim
  {
    "mhartington/formatter.nvim",
    config = function()
      require "core.formatter"
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("core.linter").setup()
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
    end,
  },

  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("core.gitsigns").setup()
    end,
    event = "BufRead",
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("core.which-key").setup()
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
    end,
  },

  -- lsp-rooter
  { 
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status Line and Bufferline
  {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
    end,
    event = "BufWinEnter",
    disable = not O.plugin.galaxyline.active,
  },

  {
    "romgrk/barbar.nvim",
    config = function()
      require "core.bufferline"
    end,
    event = "BufWinEnter",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("core.dap").setup()
    end,
    disable = not O.plugin.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not O.plugin.dap.active,
  },

  -- Builtins, these do not load by default

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("core.dashboard").setup()
    end,
    disable = not O.plugin.dashboard.active,
  },

  -- TODO: remove in favor of akinsho/nvim-toggleterm.lua
  -- Floating terminal
  -- {
  --   "numToStr/FTerm.nvim",
  --   event = "BufWinEnter",
  --   config = function()
  --     require("core.floatterm").setup()
  --   end,
  --   disable = not O.plugin.floatterm.active,
  -- },

  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal").setup()
    end,
    disable = not O.plugin.terminal.active,
  },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = function()
      require("core.zen").setup()
    end,
    disable = not O.plugin.zen.active,
  },

  ---------------------------------------------------------------------------------

  -- LANGUAGE SPECIFIC GOES HERE
  {
    "lervag/vimtex",
    ft = "tex",
  },

  -- Rust tools
  -- TODO: use lazy loading maybe?
  {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  },

  -- Elixir
  { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir", "euphoria3" } },

  -- Javascript / Typescript
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },

  -- Java
  {
    "mfussenegger/nvim-jdtls",
    -- ft = { "java" },
    disable = not O.lang.java.java_tools.active,
  },

  -- Scala
  {
    "scalameta/nvim-metals",
    disable = not O.lang.scala.metals.active,
  },
}
