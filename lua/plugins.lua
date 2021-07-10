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
  use { "kabouzeid/nvim-lspinstall", event = "VimEnter" }
  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = [[require('lv-telescope')]],
    event = "BufWinEnter",
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("lv-compe").config()
    end,
  }

  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Neoformat
  use {
    "sbdchd/neoformat",
    config = function()
      require "lv-neoformat"
    end,
    event = "BufRead",
  }

  -- NvimTree
  use {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("lv-nvimtree").config()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("lv-gitsigns").config()
    end,
    event = "BufRead",
  }

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      require "lv-which-key"
    end,
    event = "BufWinEnter",
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim" },
    config = function()
      require "lv-autopairs"
    end,
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufWinEnter",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
    end,
  }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status Line and Bufferline
  use {
    "glepnir/galaxyline.nvim",
    config = function()
      require "lv-galaxyline"
    end,
    event = "BufWinEnter",
    disable = not O.plugin.galaxyline.active,
  }

  use {
    "romgrk/barbar.nvim",
    config = function()
      require "lv-barbar"
    end,
    event = "BufWinEnter",
  }

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    event = "BufWinEnter",
    config = function()
      require "lv-dap"
    end,
    disable = not O.plugin.dap.active,
  }

  -- Debugger management
  use {
    "Pocco81/DAPInstall.nvim",
    event = "BufWinEnter",
    -- event = "BufRead",
    disable = not O.plugin.dap.active,
  }

  -- Builtins, these do not load by default

  -- Dashboard
  use {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("lv-dashboard").config()
    end,
    disable = not O.plugin.dashboard.active,
  }

  -- TODO: remove in favor of akinsho/nvim-toggleterm.lua
  -- Floating terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufWinEnter",
    config = function()
      require("lv-floatterm").config()
    end,
    disable = not O.plugin.floatterm.active,
  }

  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = function()
      require("lv-zen").config()
    end,
    disable = not O.plugin.zen.active,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"

      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }

      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
    disable = not O.plugin.indent_line.active,
  }

  -- Diffview
  use {
    "sindrets/diffview.nvim",
    event = "BufRead",
    disable = not O.plugin.diffview.active,
  }

  ---------------------------------------------------------------------------------

  -- comments in context
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    disable = not O.plugin.ts_context_commentstring.active,
  }

  -- Use project for telescope
  use {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
    disable = not O.plugin.telescope_project.active,
  }

  -- Lush Create Color Schemes
  use {
    "rktjmp/lush.nvim",
    -- cmd = {"LushRunQuickstart", "LushRunTutorial", "Lushify"},
    disable = not O.plugin.lush.active,
  }

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
    ft = { "java" },
    disable = not O.lang.java.java_tools.active,
  }

  -- use {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = {
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --   },
  --   config = function()
  --     require("null-ls").setup()
  --   end,
  -- }

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
