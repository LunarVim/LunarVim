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

local plugins = {}
return require("packer").startup(function(use)
  -- TODO: refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
  local plugins_conf = {
    { "wbthomason/packer.nvim" },
    { "neovim/nvim-lspconfig" },
    {
      "kabouzeid/nvim-lspinstall",
      event = "VimEnter",
      config = function()
        require("lspinstall").setup()
      end,
    },

    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "tjdevries/astronauta.nvim" },

    "core.telescope",
    "core.compe",
    "core.autopairs",

    -- Snippets

    { "hrsh7th/vim-vsnip", event = "InsertEnter" },
    { "rafamadriz/friendly-snippets", event = "InsertEnter" },

    "core.treesitter",
    "core.formatter",
    "core.nvimtree",
    "core.gitsigns",
    "core.which-key",
    {
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        local status_ok, nvim_comment = pcall(require, "nvim_comment")
        if not status_ok then
          return
        end
        nvim_comment.setup()
      end,
    },

    -- vim-rooter
    {
      "airblade/vim-rooter",
      config = function()
        vim.g.rooter_silent_chdir = 1
      end,
    },

    -- Icons
    { "kyazdani42/nvim-web-devicons" },

    "core.galaxyline",
    "core.bufferline",
    "core.dap",

    -- Debugger management
    {
      "Pocco81/DAPInstall.nvim",
      -- event = "BufWinEnter",
      -- event = "BufRead",
      disable = not O.plugin.dap.active,
    },

    -- Builtins, these do not load by default

    "core.dashboard",
    "core.floatterm",
    "core.zen",

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

    {
      "mfussenegger/nvim-jdtls",
      -- ft = { "java" },
      disable = not O.lang.java.java_tools.active,
    },
  }

  for _, configurations in ipairs { plugins_conf, O.user_plugins } do
    for _, plugin_conf in ipairs(configurations) do
      if type(plugin_conf) == "string" then
        local ok, plugin = pcall(require, plugin_conf)
        if ok then
          use(plugin.packer_config())
          table.insert(plugins, plugin)
        end
      else
        use(plugin_conf)
      end
    end
  end
end)
