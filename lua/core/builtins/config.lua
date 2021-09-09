local Config = {}

function Config.load(builtins)
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
        require("core.builtins.lspinstall"):configure()
      end,
    },

    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("core.builtins.telescope"):configure()
      end,
      disable = builtins.telescope.active == false,
    },
    -- Install nvim-cmp, and buffer source as a dependency
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require("core.builtins.cmp"):configure()
      end,
      requires = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
      },
      disable = builtins.cmp.active == false,
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
        require("core.builtins.autopairs"):configure()
      end,
      disable = builtins.autopairs.active == false,
    },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      -- run = ":TSUpdate",
      config = function()
        require("core.builtins.treesitter"):configure()
      end,
    },

    -- NvimTree
    {
      "kyazdani42/nvim-tree.lua",
      -- event = "BufWinOpen",
      -- cmd = "NvimTreeToggle",
      -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
      config = function()
        require("core.builtins.nvimtree"):configure()
      end,
      disable = builtins.nvimtree.active == false,
    },

    {
      "lewis6991/gitsigns.nvim",

      config = function()
        require("core.builtins.gitsigns"):configure()
      end,
      event = "BufRead",
      disable = builtins.gitsigns.active == false,
    },

    -- Whichkey
    {
      "folke/which-key.nvim",
      config = function()
        require("core.builtins.which-key"):configure()
      end,
      -- event = "BufWinEnter",
      event = "BufWinEnter",
      disable = builtins.which_key.active == false,
    },

    -- Comments
    {
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("core.builtins.comment"):configure()
      end,
      disable = builtins.comment.active == false,
    },

    -- project.nvim
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("core.builtins.project"):configure()
      end,
      disable = builtins.project.active == false,
    },

    -- Icons
    { "kyazdani42/nvim-web-devicons" },

    -- Status Line and Bufferline
    {
      -- "hoob3rt/lualine.nvim",
      "shadmansaleh/lualine.nvim",
      -- "Lunarvim/lualine.nvim",
      config = function()
        require("core.builtins.lualine"):configure()
      end,
      disable = builtins.lualine.active == false,
    },

    {
      "romgrk/barbar.nvim",
      config = function()
        require("core.builtins.bufferline"):configure()
      end,
      event = "BufWinEnter",
      disable = builtins.bufferline.active == false,
    },

    -- Debugging
    {
      "mfussenegger/nvim-dap",
      -- event = "BufWinEnter",
      config = function()
        require("core.builtins.dap"):configure()
      end,
      disable = builtins.dap.active == false,
    },

    -- Debugger management
    {
      "Pocco81/DAPInstall.nvim",
      -- event = "BufWinEnter",
      -- event = "BufRead",
      disable = builtins.dap.active == false,
    },

    -- Dashboard
    {
      "ChristianChiarulli/dashboard-nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.dashboard"):configure()
      end,
      disable = builtins.dashboard.active == false,
    },

    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.terminal"):configure()
      end,
      disable = builtins.terminal.active == false,
    },
  }
end

return Config
