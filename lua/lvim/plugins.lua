local commit = {
  bufferline = "871495d9e2dbe3314a421fd2d5e46f47de7ee537",
  cmp_buffer = "d66c4c2d376e5be99db68d2362cd94d250987525",
  cmp_luasnip = "d6f837f4e8fe48eeae288e638691b91b97d1737f",
  cmp_nvim_lsp = "ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
  cmp_path = "466b6b8270f7ba89abd59f402c73f63c7331ff6e",
  comment = "00ed8f612b7bcbaf9df870781ed372ee8c00d6a8",
  dapinstall = "24923c3819a450a772bb8f675926d530e829665f",
  dashboard_nvim = "d82ddae95fd4dc4c3b7bbe87f09b1840fbf20ecb",
  fixcursorhold = "1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1",
  friendly_snippets = "ad07b2844021b20797adda5b483265802559a693",
  gitsigns = "779f4eb59047ef7faa41e71d261d041edfabfb39",
  lua_dev = "a0ee77789d9948adce64d98700cc90cecaef88d5",
  lualine = "d2e0ac595b8e315b454f4384edb2eba7807a8401",
  luasnip = "3d544b66c0ded7c01151559a83bd3ff9be6a40e8",
  nlsp_settings = "61d95800be78ecea8e16297f36fef52c412d3602",
  null_ls = "15d3aabc2b440293ecf6c85f25ca9fa645a468ae",
  nvim_autopairs = "d2cde7c5802b34d6391a8a3555a3b7b56482f2aa",
  nvim_cmp = "1001683bee3a52a7b7e07ba9d391472961739c7b",
  nvim_dap = "edb22a824e33f5244c98dbaa91f749f0d6390a94",
  nvim_lsp_installer = "6e6d75b7a446a13ec2bdaaf7934c071936ad3d8c",
  nvim_lspconfig = "cf2fc1d5149dc097e8c02c607f0f0c97c5099ae8",
  nvim_notify = "f81b48d298c0ff7479b66568d9cc1a4794c196d0",
  nvim_tree = "ac858a28a2ca673bbca74af005442e58e015f19e",
  nvim_treesitter = "cada76c4901e2389c0f82ac11d0c9c61d5205e90",
  nvim_ts_context_commentstring = "097df33c9ef5bbd3828105e4bee99965b758dc3f",
  nvim_web_devicons = "4415d1aaa56f73b9c05795af84d625c610b05d3b",
  packer = "c576ab3f1488ee86d60fd340d01ade08dcabd256",
  plenary = "14dfb4071022b22e08384ee125a5607464b6d397",
  popup = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
  project = "cef52b8da07648b750d7f1e8fb93f12cb9482988",
  schemastore = "120e95a9e3d60a7410adb1be102268091ed400fb",
  structlog = "6f1403a192791ff1fa7ac845a73de9e860f781f1",
  telescope = "b501d9ecb7d8181e2238620c919740025e8b2096",
  telescope_fzf_native = "8ec164b541327202e5e74f99bcc5fe5845720e18",
  toggleterm = "e97d0c1046512e975a9f3fa95afe98f312752b1c",
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
    "akinsho/bufferline.nvim",
    commit = commit.bufferline,
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

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    commit = commit.schemastore,
  },
}
