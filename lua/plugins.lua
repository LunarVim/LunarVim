local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  -- package_root = require("packer.util").join_paths(vim.fn.stdpath "data", "lvim", "pack"),
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  -- TODO: refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
  use { "neovim/nvim-lspconfig" }
  use {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require("lspinstall").setup()
    end,
  }

  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = [[require('core.telescope').setup()]],
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    -- event = "InsertEnter",
    config = function()
      require("core.compe").setup()
    end,
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require "core.autopairs"
    end,
  }

  -- Snippets

  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("core.treesitter").setup()
    end,
  }

  -- Formatter.nvim
  use {
    "mhartington/formatter.nvim",
    config = function()
      require "core.formatter"
    end,
  }

  -- Linter
  use {
    "mfussenegger/nvim-lint",
    config = function()
      require("core.linter").setup()
    end,
  }

  -- NvimTree
  use {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("core.nvimtree").setup()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("core.gitsigns").setup()
    end,
    event = "BufRead",
  }

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require("core.which-key").setup()
    end,
    event = "BufWinEnter",
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
    end,
  }

  -- vim-rooter
  use {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_silent_chdir = 1
    end,
  }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status Line and Bufferline
  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
    end,
    event = "BufWinEnter",
    disable = not O.plugin.galaxyline.active,
  }

  use {
    "romgrk/barbar.nvim",
    config = function()
      require "core.bufferline"
    end,
    event = "BufWinEnter",
  }

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("core.dap").setup()
    end,
    disable = not O.plugin.dap.active,
  }

  -- Debugger management
  use {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not O.plugin.dap.active,
  }

  -- Builtins, these do not load by default

  -- Dashboard
  use {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("core.dashboard").setup()
    end,
    disable = not O.plugin.dashboard.active,
  }

  -- TODO: remove in favor of akinsho/nvim-toggleterm.lua
  -- Floating terminal
  -- use {
  --   "numToStr/FTerm.nvim",
  --   event = "BufWinEnter",
  --   config = function()
  --     require("core.floatterm").setup()
  --   end,
  --   disable = not O.plugin.floatterm.active,
  -- }

  use {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal").setup()
    end,
    disable = not O.plugin.terminal.active,
  }

  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = function()
      require("core.zen").setup()
    end,
    disable = not O.plugin.zen.active,
  }

  ---------------------------------------------------------------------------------

  -- LANGUAGE SPECIFIC GOES HERE
  use {
    "lervag/vimtex",
    ft = "tex",
  }

  -- Rust tools
  -- TODO: use lazy loading maybe?
  use {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  }

  -- Elixir
  use { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir", "euphoria3" } }

  -- Javascript / Typescript
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  }

  -- Java
  use {
    "mfussenegger/nvim-jdtls",
    -- ft = { "java" },
    disable = not O.lang.java.java_tools.active,
  }

  -- Scala
  use {
    "scalameta/nvim-metals",
    disable = not O.lang.scala.metals.active,
  }

  -- Install user plugins
  for _, plugin in pairs(O.user_plugins) do
    packer.use(plugin)
  end
end)
