local commit = {
  barbar = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
  cmp_buffer = "f83773e2f433a923997c5faad7ea689ec24d1785",
  cmp_luasnip = "d6f837f4e8fe48eeae288e638691b91b97d1737f",
  cmp_nvim_lsp = "ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
  cmp_path = "c5230cb439df9547294678d0f1c1465ad7989e5f",
  comment = "22e71071d9473996563464fde19b108e5504f892",
  dapinstall = "24923c3819a450a772bb8f675926d530e829665f",
  dashboard_nvim = "d82ddae95fd4dc4c3b7bbe87f09b1840fbf20ecb",
  fixcursorhold = "0e4e22d21975da60b0fd2d302285b3b603f9f71e",
  friendly_snippets = "4f6bd8eb5fbe0e45d57e732783ead2c3a01f549c",
  gitsigns = "2fa3716bc4690da96d885becdf9988603f0756f0",
  lua_dev = "a0ee77789d9948adce64d98700cc90cecaef88d5",
  lualine = "9208bae98fd5d1ab6145868a8c48bfee53c1a499",
  luasnip = "35322c97b041542f95c85e87a8215892ea4137d5",
  nlsp_settings = "b4f48afb308e622adc8ea0f3aaff4c1e1344515a",
  null_ls = "2ae4a5e2e2b35716c44c104ef1afa35ecb40c444",
  nvim_autopairs = "97e454ce9b1371373105716d196c1017394bc947",
  nvim_cmp = "d93104244c3834fbd8f3dd01da9729920e0b5fe7",
  nvim_dap = "c9a58267524f560112ecb6faa36ab2b5bc2f78a3",
  nvim_lsp_installer = "c2bde3911892a51323219f7cfc9bb50b49afd29f",
  nvim_lspconfig = "e7df7ecae0b0d2f997ea65e951ddbe98ca3e154b",
  nvim_notify = "15f52efacd169ea26b0f4070451d3ea53f98cd5a",
  nvim_tree = "2dfed89af7724f9e71d2fdbe3cde791a93e9b9e0",
  nvim_treesitter = "cc89dda2410f5aa9160f45a6acd4db0ee26fe632",
  nvim_ts_context_commentstring = "097df33c9ef5bbd3828105e4bee99965b758dc3f",
  nvim_web_devicons = "634e26818f2bea9161b7efa76735746838971824",
  packer = "7182f0ddbca2dd6f6723633a84d47f4d26518191",
  plenary = "563d9f6d083f0514548f2ac4ad1888326d0a1c66",
  popup = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
  project = "cef52b8da07648b750d7f1e8fb93f12cb9482988",
  structlog = "6f1403a192791ff1fa7ac845a73de9e860f781f1",
  telescope = "3a3c9a3c8ba3fb14121ef5c50a87173dcb969416",
  telescope_fzf_native = "b8662b076175e75e6497c59f3e2799b879d7b954",
  toggleterm = "d2ceb2ca3268d09db3033b133c0ee4642e07f059",
  which_key = "28d2bd129575b5e9ebddd88506601290bb2bb221",
}

return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim", commit = commit.packer },
  { "neovim/nvim-lspconfig", commit = commit.nvim_lspconfig },
  { "tamago324/nlsp-settings.nvim", commit = commit.nlsp_settings },
  {
    "jose-elias-alvarez/null-ls.nvim",
    commit = commit.null_ls,
  },
  { "antoinemadec/FixCursorHold.nvim", commit = commit.fixcursorhold }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  {
    "williamboman/nvim-lsp-installer",
    commit = commit.nvim_lsp_installer,
  },
  {
    "rcarriga/nvim-notify",
    commit = commit.nvim_notify,
    disable = not lvim.builtin.notify.active,
    config = function()
      require("lvim.core.notify").setup()
    end,
    event = "BufRead",
  },
  { "Tastyep/structlog.nvim", commit = commit.structlog },

  { "nvim-lua/popup.nvim", commit = commit.popup },
  { "nvim-lua/plenary.nvim", commit = commit.plenary },
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
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    requires = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    commit = commit.friendly_snippets,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
    commit = commit.luasnip,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    commit = commit.cmp_nvim_lsp,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    commit = commit.cmp_luasnip,
  },
  {
    "hrsh7th/cmp-buffer",
    commit = commit.cmp_buffer,
  },
  {
    "hrsh7th/cmp-path",
    commit = commit.cmp_path,
  },
  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
    commit = commit.lua_dev,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    commit = commit.nvim_autopairs,
    -- event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    disable = not lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    commit = commit.nvim_treesitter,
    branch = vim.fn.has "nvim-0.6" == 1 and "master" or "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("lvim.core.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = commit.nvim_ts_context_commentstring,
    event = "BufReadPost",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    commit = commit.nvim_tree,
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
  { "kyazdani42/nvim-web-devicons", commit = commit.nvim_web_devicons },

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
    commit = commit.nvim_dap,
    -- event = "BufWinEnter",
    config = function()
      require("lvim.core.dap").setup()
    end,
    disable = not lvim.builtin.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    commit = commit.dapinstall,
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
