local commit = {
  barbar = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
  cmp_buffer = "a0fe52489ff6e235d62407f8fa72aef80222040a",
  cmp_luasnip = "75bf6434f175206cd219f9d2bbcae154a009346c",
  cmp_nvim_lsp = "134117299ff9e34adde30a735cd8ca9cf8f3db81",
  cmp_nvim_lua = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
  cmp_path = "d83839ae510d18530c6d36b662a9e806d4dceb73",
  comment = "58d489fb7f18c3652adf7e8e1fff9d3281a8fc6a",
  dapinstall = "dd09e9dd3a6e29f02ac171515b8a089fb82bb425",
  fixcursorhold = "0e4e22d21975da60b0fd2d302285b3b603f9f71e",
  friendly_snippets = "4a9516c116f8d3a5766fcb8ac91b176979612d5d",
  gitsigns = "aaf680472187798d5945e39179b540bd3bf80341",
  lualine = "5596c2a25a49ca235613c804169b9063e20b05f5",
  luasnip = "577045e9adf325e58f690f4d4b4a293f3dcec1b3",
  nlsp_settings = "599edc32707f53bd9b0739879f013b3bf162ea4e",
  null_ls = "fb9e2a64ae8e43c2255025064cfee37dc7d6a752",
  nvim_autopairs = "04cd1779f81e9d50d5a116c5dccd054b275bd191",
  nvim_cmp = "af07ff9b7973e95eff9e0275e13fe0350281208b",
  nvim_dap = "3b3027e0ca98775000e1ba727d8f292e821f9f03",
  nvim_lsp_installer = "fcd5d79a7f4966645e9d2f512b85b72f7de0dde2",
  nvim_lspconfig = "e6d95863a336b7e52c92b38c62aa60b469254d14",
  nvim_notify = "ef027e34b618eac42fb0111c1db670ba01793039",
  nvim_tree = "2e33b1654384921ec1cc9656a2018744f3f1ce81",
  nvim_treesitter = "1d66657e6d0f1f8f79ddc48ff1dac9788694cc2d",
  nvim_ts_context_commentstring = "9f5e422e1030e7073e593ad32c5354aa0bcb0176",
  nvim_web_devicons = "344331467509802e1af200f08ec3da278be5cbba",
  packer = "851c62c5ecd3b5adc91665feda8f977e104162a5",
  plenary = "e6267f79481064eee53950571f53cbaafb08417d",
  popup = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
  project = "71d0e23dcfc43cfd6bb2a97dc5a7de1ab47a6538",
  structlog = "6f1403a192791ff1fa7ac845a73de9e860f781f1",
  telescope = "80cdb00b221f69348afc4fb4b701f51eb8dd3120", -- see telescope.nvim#1549
  telescope_fzf_native = "b8662b076175e75e6497c59f3e2799b879d7b954",
  toggleterm = "265bbff68fbb8b2a5fb011272ec469850254ec9f",
  which_key = "0fd9de78fe09215e1b7c6173ff1b0b90c8ed6ec4",
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
    "hrsh7th/cmp-nvim-lua",
    commit = commit.cmp_nvim_lua,
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
