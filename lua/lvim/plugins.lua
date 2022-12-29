-- local require = require("lvim.utils.require").require
local core_plugins = {
  { "folke/lazy.nvim" },
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
  },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      require("lvim.core.mason").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "lunarvim/lunar.nvim",
  },
  { "Tastyep/structlog.nvim" },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim", lazy = true },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    branch = "0.1.x",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    enabled = lvim.builtin.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    requires = { "nvim-telescope/telescope.nvim" },
    build = "make",
    enabled = lvim.builtin.telescope.active,
  },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    config = function()
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    enabled = lvim.builtin.luasnip.sources.friendly_snippets,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local utils = require "lvim.utils"
      local paths = {}
      if lvim.builtin.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "friendly-snippets")
      end
      local user_snippets = utils.join_paths(get_config_dir(), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",
    lazy = true,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
    lazy = true,
  },
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
    lazy = true,
  },
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",
    lazy = true,
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    -- event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    enabled = lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    -- run = ":TSUpdate",
    config = function()
      require("lvim.core.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    lazy = true,
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    enabled = lvim.builtin.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    lazy = true,
    config = function()
      require("lvim.core.lir").setup()
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
    enabled = lvim.builtin.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "BufRead",
    enabled = lvim.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    lazy = true,
    config = function()
      require("lvim.core.which-key").setup()
    end,
    event = "BufWinEnter",
    enabled = lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("lvim.core.comment").setup()
    end,
    enabled = lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("lvim.core.project").setup()
    end,
    enabled = lvim.builtin.project.active,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    enabled = lvim.use_icons,
  },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("lvim.core.lualine").setup()
    end,
    enabled = lvim.builtin.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("lvim.core.breadcrumbs").setup()
    end,
    enabled = lvim.builtin.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    lazy = true,
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    enabled = lvim.builtin.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- event = "BufWinEnter",
    config = function()
      require("lvim.core.dap").setup()
    end,
    enabled = lvim.builtin.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    config = function()
      require("lvim.core.dap").setup_ui()
    end,
    enabled = lvim.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.core.alpha").setup()
    end,
    enabled = lvim.builtin.alpha.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require("lvim.core.terminal").setup()
    end,
    enabled = lvim.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("lvim.core.illuminate").setup()
    end,
    enabled = lvim.builtin.illuminate.active,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("lvim.core.indentlines").setup()
    end,
    enabled = lvim.builtin.indentlines.active,
  },

  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if lvim and lvim.colorscheme == "onedarker" then
          require("onedarker").setup()
          lvim.builtin.lualine.options.theme = "onedarker"
        end
      end)
    end,
    enabled = lvim.colorscheme == "onedarker",
  },

  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").config(lvim.builtin.bigfile.config)
      end)
    end,
    enabled = lvim.builtin.bigfile.active,
  },
}

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local content = vim.fn.readfile(default_snapshot_path)
local default_sha1 = assert(vim.fn.json_decode(content))

local get_default_sha1 = function(spec)
  local _, short_name = pcall(function()
    return require("lazy.core.plugin").Spec.get_name(spec[1])
  end)
  return short_name and default_sha1[short_name] and default_sha1[short_name].commit
end

if not vim.env.LVIM_DEV_MODE then
  --  Manually lock the commit hashes of core plugins
  for _, spec in ipairs(core_plugins) do
    spec["commit"] = get_default_sha1(spec)
  end
end

return core_plugins
