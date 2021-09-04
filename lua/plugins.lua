local Plugins = {}

function Plugins.defaults(config)
  return {
    -- Packer can manage itself as an optional plugin
    { "wbthomason/packer.nvim" },
    { "neovim/nvim-lspconfig" },
    { "tamago324/nlsp-settings.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    {
      "kabouzeid/nvim-lspinstall",
      event = "VimEnter",
      config = function()
        require("core.builtins.lspinstall"):config()
      end,
    },

    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("core.builtins.telescope"):config()
      end,
      disable = not lvim.builtins.telescope.active,
    },
    -- Install nvim-cmp, and buffer source as a dependency
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require("core.cmp"):config()
      end,
      requires = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
      },
    },
    {
      "rafamadriz/friendly-snippets",
      -- event = "InsertCharPre",
      -- disable = not lvim.builtin.compe.active,
    },

    -- Autopairs
    {
      "windwp/nvim-autopairs",
      -- event = "InsertEnter",
      after = "nvim-cmp",
      config = function()
        require("core.builtins.autopairs"):config()
      end,
      disable = not lvim.builtin.autopairs.active,
    },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      -- run = ":TSUpdate",
      config = function()
        require("core.builtins.treesitter"):config()
      end,
    },

    -- NvimTree
    {
      "kyazdani42/nvim-tree.lua",
      -- event = "BufWinOpen",
      -- cmd = "NvimTreeToggle",
      -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
      config = function()
        require("core.builtins.nvimtree"):config()
      end,
      disable = not lvim.builtins.nvimtree.active,
    },

    {
      "lewis6991/gitsigns.nvim",

      config = function()
        require("core.builtins.gitsigns"):config()
      end,
      event = "BufRead",
      disable = not lvim.builtins.gitsigns.active,
    },

    -- Whichkey
    {
      "folke/which-key.nvim",
      config = function()
        require("core.builtins.which-key"):config()
      end,
      -- event = "BufWinEnter",
      -- disable = not lvim.builtins.which_key.active,
    },

    -- Comments
    {
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("core.builtins.comment"):config()
      end,
      disable = not lvim.builtins.comment.active,
    },

    -- project.nvim
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("core.builtins.project"):config()
      end,
      disable = not lvim.builtins.project.active,
    },

    -- Icons
    { "kyazdani42/nvim-web-devicons" },

    -- Status Line and Bufferline
    {
      -- "hoob3rt/lualine.nvim",
      "shadmansaleh/lualine.nvim",
      -- "Lunarvim/lualine.nvim",
      config = function()
        require("core.builtins.lualine"):config()
      end,
      disable = not lvim.builtins.lualine.active,
    },

    {
      "romgrk/barbar.nvim",
      config = function()
        require("core.builtins.bufferline"):config()
      end,
      event = "BufWinEnter",
      disable = not lvim.builtins.bufferline.active,
    },

    -- Debugging
    {
      "mfussenegger/nvim-dap",
      -- event = "BufWinEnter",
      config = function()
        require("core.builtins.dap"):config()
      end,
      disable = not lvim.builtins.dap.active,
    },

    -- Debugger management
    {
      "Pocco81/DAPInstall.nvim",
      -- event = "BufWinEnter",
      -- event = "BufRead",
      disable = not lvim.builtins.dap.active,
    },

    -- Dashboard
    {
      "ChristianChiarulli/dashboard-nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.dashboard"):config()
      end,
      disable = not lvim.builtins.dashboard.active,
    },

    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.terminal"):config()
      end,
      disable = not lvim.builtins.terminal.active,
    },
  }
end

return Plugins
