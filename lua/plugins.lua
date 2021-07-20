function call_config_done_callback(plugin_variable_name, module_name)
  local plugin_variable = O.plugin[plugin_variable_name]
  if plugin_variable and plugin_variable.on_config_done then
    if module_name then
      plugin_variable.on_config_done(require(module_name))
    else
      plugin_variable.on_config_done()
    end
  else
  end
end

return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },

  -- TODO: refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
  { "neovim/nvim-lspconfig" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      require("lspinstall").setup()
      call_config_done_callback("lspinstall", "lspinstall")
    end,
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "tjdevries/astronauta.nvim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
      call_config_done_callback("telescope", "telescope")
    end,
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-compe",
    -- event = "InsertEnter",
    config = function()
      require("core.compe").setup()
      call_config_done_callback("compe", "compe")
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require "core.autopairs"
      call_config_done_callback("autopairs", "nvim-autopairs")
    end,
  },

  -- Snippets

  { "hrsh7th/vim-vsnip", event = "InsertEnter" },
  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("core.treesitter").setup()
      call_config_done_callback("treesitter", "nvim-treesitter.configs")
    end,
  },

  -- Formatter.nvim
  {
    "mhartington/formatter.nvim",
    config = function()
      require "core.formatter"
      call_config_done_callback("formatter", "formatter")
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("core.linter").setup()
      call_config_done_callback("lint", "lint")
    end,
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("core.nvimtree").setup()
      call_config_done_callback("nvimtree", "nvim-tree.config")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("core.gitsigns").setup()
      call_config_done_callback("gitsigns", "gitsigns")
    end,
    event = "BufRead",
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("core.which-key").setup()
      call_config_done_callback("whick_key", "which-key")
    end,
    event = "BufWinEnter",
  },

  -- Comments
  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
      call_config_done_callback("comment", "nvim_comment")
    end,
  },

  -- vim-rooter
  {
    "airblade/vim-rooter",
    config = function()
      vim.g.rooter_silent_chdir = 1
      call_config_done_callback "rooter"
    end,
  },

  -- Icons
  { "kyazdani42/nvim-web-devicons" },

  -- Status Line and Bufferline
  {
    "glepnir/galaxyline.nvim",
    config = function()
      require "core.galaxyline"
      call_config_done_callback("galaxyline", "galaxyline")
    end,
    event = "BufWinEnter",
    disable = not O.plugin.galaxyline.active,
  },

  {
    "romgrk/barbar.nvim",
    config = function()
      require "core.bufferline"
      call_config_done_callback "bufferline"
    end,
    event = "BufWinEnter",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("core.dap").setup()
      call_config_done_callback("dap", "dap")
    end,
    disable = not O.plugin.dap.active,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not O.plugin.dap.active,
  },

  -- Builtins, these do not load by default

  -- Dashboard
  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("core.dashboard").setup()
      call_config_done_callback("dashboard", "dashboard")
    end,
    disable = not O.plugin.dashboard.active,
  },

  -- TODO: remove in favor of akinsho/nvim-toggleterm.lua
  -- Floating terminal
  -- {
  --   "numToStr/FTerm.nvim",
  --   event = "BufWinEnter",
  --   config = function()
  --     require("core.floatterm").setup()
  --   end,
  --   disable = not O.plugin.floatterm.active,
  -- },

  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("core.terminal").setup()
      call_config_done_callback("terminal", "toggleterm")
    end,
    disable = not O.plugin.terminal.active,
  },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = function()
      require("core.zen").setup()
      call_config_done_callback("zen", "zen-mode")
    end,
    disable = not O.plugin.zen.active,
  },

  ---------------------------------------------------------------------------------

  -- LANGUAGE SPECIFIC GOES HERE
  {
    "lervag/vimtex",
    ft = "tex",
  },

  -- Rust tools
  -- TODO: use lazy loading maybe?
  {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  },

  -- Elixir
  { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir", "euphoria3" } },

  -- Javascript / Typescript
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },

  -- Java
  {
    "mfussenegger/nvim-jdtls",
    -- ft = { "java" },
    disable = not O.lang.java.java_tools.active,
  },

  -- Scala
  {
    "scalameta/nvim-metals",
    disable = not O.lang.scala.metals.active,
  },
}
