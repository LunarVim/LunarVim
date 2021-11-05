
local commit = {
  packer = "7f62848f3a92eac61ae61def5f59ddb5e2cc6823",
  lsp_config = "6224c54a9945a52bf43a8bc1a42a112084590c0b",
  nlsp_settings = "29f49afe27b43126d45a05baf3161a28b929f2f1",
  null_ls = "64b269b51c7490660dcb2008f59ae260f2cdbbe4",
  fix_cursor_hold = "0e4e22d21975da60b0fd2d302285b3b603f9f71e",
  lsp_installer = "6cb24638a42f6f750f1bac40cf9f18dcb0d0d489",
  nvim_notify = "ee79a5e2f8bde0ebdf99880a98d1312da83a3caa",
  structlog = "6f1403a192791ff1fa7ac845a73de9e860f781f1",
  popup = "f91d80973f80025d4ed00380f2e06c669dfda49d",
  plenary = "96e821e8001c21bc904d3c15aa96a70c11462c5f",
  telescope = "078a48db9e0720b07bfcb8b59342c5305a1d1fdc",
  telescope_fzf_native = "59e38e1661ffdd586cb7fc22ca0b5a05c7caf988",
  nvim_cmp = "1774ff0f842146521c63707245d3de5db2bb3732",
  friendly_snippets = "94f1d917435c71bc6494d257afa90d4c9449aed2",
  autopairs = "f858ab38b532715dbaf7b2773727f8622ba04322",
  treesitter = "47cfda2c6711077625c90902d7722238a8294982",
  context_commentstring = "159c5b9a2cdb8a8fe342078b7ac8139de76bad62",
  nvim_tree = "f92b7e7627c5a36f4af6814c408211539882c4f3",
  gitsigns = "61a81b0c003de3e12555a5626d66fb6a060d8aca",
  which_key = "d3032b6d3e0adb667975170f626cb693bfc66baa",
  comment = "620445b87a0d1640fac6991f9c3338af8dec1884",
  project = "3a1f75b18f214064515ffba48d1eb7403364cc6a",
  nvim_web_devicons = "ee101462d127ed6a5561ce9ce92bfded87d7d478",
  lualine = "3f5cdc51a08c437c7705e283eebd4cf9fbb18f80",
  barbar = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
  dap = "dd778f65dc95323f781f291fb7c5bf3c17d057b1",
  dap_install = "dd09e9dd3a6e29f02ac171515b8a089fb82bb425",
  toggleterm = "5f9ba91157a25be5ee7395fbc11b1a8f25938365"
}

return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim",
    commit = commit.packer,
  },
  { "neovim/nvim-lspconfig",
    commit = commit.lsp_config,

  },
  { "tamago324/nlsp-settings.nvim",
    commit = commit.nlsp_settings,
  },
  { "jose-elias-alvarez/null-ls.nvim",
    commit = commit.null_ls,
  },
  { "antoinemadec/FixCursorHold.nvim",
    commit = commit.fix_cursor_hold,
  }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  {
    "williamboman/nvim-lsp-installer",
    commit = commit.lsp_installer,
  },
  {
    "rcarriga/nvim-notify",
    commit = commit.nvim_notify,
    disable = not lvim.builtin.notify.active,
  },
  { "Tastyep/structlog.nvim",
    commit = commit.structlog,
  },

  { "nvim-lua/popup.nvim",
    commit = commit.popup,
  },
  { "nvim-lua/plenary.nvim",
    commit = commit.plenary,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    commit = commit.telescope,
    config = function()
      require("lvim.core.telescope").setup()
    end,
    disable = not lvim.builtin.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = commit.telescope_fzf_native,
    run = "make",
    disable = not lvim.builtin.telescope.active,
  },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    commit = commit.nvim_cmp,
    config = function()
      require("lvim.core.cmp").setup()
    end,
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
    },
    run = function()
      -- cmp's config requires cmp to be installed to run the first time
      if not lvim.builtin.cmp then
        require("lvim.core.cmp").config()
      end
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    commit = commit.friendly_snippets,
    -- event = "InsertCharPre",
    -- disable = not lvim.builtin.compe.active,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    commit = commit.autopairs,
    -- event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    disable = not lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    commit = commit.treesitter,
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("lvim.core.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = commit.context_commentstring,
    event = "BufReadPost",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = commit.nvim_tree,
    commit = "f92b7e7627c5a36f4af6814c408211539882c4f3",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    disable = not lvim.builtin.nvimtree.active,
  },

  {
    "lewis6991/gitsigns.nvim",
    commit = commit.gitsigns,

    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not lvim.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    commit = commit.which_key,
    config = function()
      require("lvim.core.which-key").setup()
    end,
    event = "BufWinEnter",
    disable = not lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    commit = commit.comment,
    event = "BufRead",
    config = function()
      require("lvim.core.comment").setup()
    end,
    disable = not lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    commit = commit.project,
    config = function()
      require("lvim.core.project").setup()
    end,
    disable = not lvim.builtin.project.active,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons",
    commit = commit.nvim_web_devicons,
  },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    commit = commit.lualine,
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("lvim.core.lualine").setup()
    end,
    disable = not lvim.builtin.lualine.active,
  },

  {
    "romgrk/barbar.nvim",
    commit = commit.barbar,
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    event = "BufWinEnter",
    disable = not lvim.builtin.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    commit = commit.dap,
    -- event = "BufWinEnter",
    config = function()
      require("lvim.core.dap").setup()
    end,
    disable = not lvim.builtin.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    commit = commit.dap_install,
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not lvim.builtin.dap.active,
  },

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("lvim.core.dashboard").setup()
    end,
    disable = not lvim.builtin.dashboard.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    commit = commit.toggleterm,
    event = "BufWinEnter",
    config = function()
      require("lvim.core.terminal").setup()
    end,
    disable = not lvim.builtin.terminal.active,
  },
}
