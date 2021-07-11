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
    config = [[ require("lspinstall").setup() ]],
  }

  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = [[ require('lv-telescope') ]],
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    -- event = "InsertEnter",
    config = [[ require("core.completion").config() ]],
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = { "telescope.nvim" },
    config = [[ require('core.autopairs') ]],
  }

  -- Snippets

  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Formatter.nvim
  use {
    "mhartington/formatter.nvim",
    config = [[ require('core.formatter') ]],
    event = "BufRead",
  }

  -- NvimTree
  use {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = [[ require('core.nvimtree').config() ]],
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = [[ require('core.gitsigns').config() ]],
    event = "BufRead",
    disable = not O.plugin.gitsigns.active,
  }

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require "lv-which-key"
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
    disable = not O.plugin.nvim_comment.active,
  }

  -- whichkey
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
    config = [[ require('core.statusline') ]],
    event = "BufWinEnter",
    disable = not O.plugin.galaxyline.active,
  }

  use {
    "romgrk/barbar.nvim",
    config = [[ require('core.barbar') ]],
    event = "BufWinEnter",
    disable = not O.plugin.barbar.active,
  }

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = [[ require('core.dap') ]],
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
    -- event = "BufWinEnter",
    -- cmd = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks" },
  	config = [[ require('core.dashboard').config() ]],
    disable = not O.plugin.dashboard.active,
  }

  -- TODO: remove in favor of akinsho/nvim-toggleterm.lua
  -- Floating terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufWinEnter",
    config = [[ require('core.floatterm').config() ]],
    disable = not O.plugin.floatterm.active,
  }

  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = [[ require("core.zen").config() ]],
    disable = not O.plugin.zen.active,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = [[ require('core.indent') ]],
    disable = not O.plugin.indent_line.active,
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

  use {
    "mfussenegger/nvim-jdtls",
    -- ft = { "java" },
    disable = not O.lang.java.java_tools.active,
  }

  -- Custom semantic text objects
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    disable = not O.plugin.ts_textobjects.active,
  }

  -- Smart text objects
  use {
    "RRethy/nvim-treesitter-textsubjects",
    disable = not O.plugin.ts_textsubjects.active,
  }

  -- Text objects using hint labels
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    event = "BufRead",
    disable = not O.plugin.ts_hintobjects.active,
  }

  for _, plugin in pairs(O.user_plugins) do
    packer.use(plugin)
  end
end)
