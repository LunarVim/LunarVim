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
      disable = not config:get("telescope.active", true),
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
      disable = not config:get("autopairs.active", true),
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
      disable = not config:get("nvimtree.active", true),
    },

    {
      "lewis6991/gitsigns.nvim",

      config = function()
        require("core.builtins.gitsigns"):configure()
      end,
      event = "BufRead",
      disable = not config:get("gitsigns.active", true),
    },

    -- Whichkey
    {
      "folke/which-key.nvim",
      config = function()
        require("core.builtins.which-key"):configure()
      end,
      -- event = "BufWinEnter",
      event = "BufWinEnter",
      disable = not config:get("which_key.active", true),
    },

    -- Comments
    {
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("core.builtins.comment"):configure()
      end,
      disable = not config:get("comment.active", true),
    },

    -- project.nvim
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("core.builtins.project"):configure()
      end,
      disable = not config:get("project.active", true),
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
      disable = not config:get("lualine.active", true),
    },

    {
      "romgrk/barbar.nvim",
      config = function()
        require("core.builtins.bufferline"):configure()
      end,
      event = "BufWinEnter",
      disable = not config:get("bufferline.active", true),
    },

    -- Debugging
    {
      "mfussenegger/nvim-dap",
      -- event = "BufWinEnter",
      config = function()
        require("core.builtins.dap"):configure()
      end,
      disable = not config:get("dap.active", true),
    },

    -- Debugger management
    {
      "Pocco81/DAPInstall.nvim",
      -- event = "BufWinEnter",
      -- event = "BufRead",
      disable = not config:get("dap.active", true),
    },

    -- Dashboard
    {
      "ChristianChiarulli/dashboard-nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.dashboard"):configure()
      end,
      disable = not config:get("dashboard.active", true),
    },

    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      event = "BufWinEnter",
      config = function()
        require("core.builtins.terminal"):configure()
      end,
      disable = not config:get("terminal.active", true),
    },
  }
end

return Plugins
