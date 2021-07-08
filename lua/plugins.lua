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
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"

  -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
  use { "neovim/nvim-lspconfig" }
  use { "kabouzeid/nvim-lspinstall", event = "BufRead" }
  -- Telescope
  use { "nvim-lua/popup.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "tjdevries/astronauta.nvim" }
  use {
    "nvim-telescope/telescope.nvim",
    config = [[require('lv-telescope')]],
    --event = "BufEnter",
  }

  -- Autocomplete
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("lv-compe").config()
    end,
  }

  use { "hrsh7th/vim-vsnip", event = "InsertEnter" }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Neoformat
  use { "sbdchd/neoformat" }

  use {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufEnter",
    -- cmd = "NvimTreeToggle",
    commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("lv-nvimtree").config()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("lv-gitsigns").config()
    end,
    event = "BufRead",
  }

  -- whichkey
  use { "folke/which-key.nvim" }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim" },
    config = function()
      require "lv-autopairs"
    end,
  }

  -- Comments
  use {
    "terrortylor/nvim-comment",
    event = "BufRead",
    -- cmd = "CommentToggle",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
    end,
  }

  -- Color
  use { "christianchiarulli/nvcode-color-schemes.vim", opt = true }

  -- Icons
  use { "kyazdani42/nvim-web-devicons" }

  -- Status Line and Bufferline
  use { "glepnir/galaxyline.nvim" }

  use {
    "romgrk/barbar.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<S-x>", ":BufferClose<CR>", { noremap = true, silent = true })
    end,
    -- event = "BufRead",
  }

  -- Builtins, these do not load by default

  -- Dashboard
  use {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    -- cmd = { "Dashboard", "DashboardNewFile", "DashboardJumpMarks" },
    -- config = function()
    --   require("lv-dashboard").config()
    -- end,
    disable = not O.plugin.dashboard.active,
    -- opt = true,
  }
  -- Zen Mode
  use {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    -- event = "BufRead",
    config = function()
      require("lv-zen").config()
    end,
    disable = not O.plugin.zen.active,
  }

  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require "lv-colorizer"
      -- vim.cmd "ColorizerReloadAllBuffers"
    end,
    disable = not O.plugin.colorizer.active,
  }

  -- Treesitter playground
  use {
    "nvim-treesitter/playground",
    event = "BufRead",
    disable = not O.plugin.ts_playground.active,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"

      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }

      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
    disable = not O.plugin.indent_line.active,
  }

  -- comments in context
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    disable = not O.plugin.ts_context_commentstring.active,
  }

  -- Symbol Outline
  use {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    disable = not O.plugin.symbol_outline.active,
  }
  -- diagnostics
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    disable = not O.plugin.trouble.active,
  }

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    config = function()
      local status_ok, dap = pcall(require, "dap")
      if not status_ok then
        return
      end
      -- require "dap"
      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
      })
      dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
    end,
    disable = not O.plugin.debug.active,
  }

  -- Floating terminal
  use {
    "numToStr/FTerm.nvim",
    event = "BufWinEnter",
    config = function()
      require("lv-floatterm").config()
    end,
    disable = not O.plugin.floatterm.active,
  }

  -- Use fzy for telescope
  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    event = "BufRead",
    disable = not O.plugin.telescope_fzy.active,
  }

  -- Use project for telescope
  use {
    "nvim-telescope/telescope-project.nvim",
    event = "BufRead",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
    disable = not O.plugin.telescope_project.active,
  }

  -- Sane gx for netrw_gx bug
  use {
    "felipec/vim-sanegx",
    event = "BufRead",
    disable = not O.plugin.sanegx.active,
  }

  -- Diffview
  use {
    "sindrets/diffview.nvim",
    event = "BufRead",
    disable = not O.plugin.diffview.active,
  }

  -- Lush Create Color Schemes
  use {
    "rktjmp/lush.nvim",
    -- cmd = {"LushRunQuickstart", "LushRunTutorial", "Lushify"},
    disable = not O.plugin.lush.active,
  }

  -- Debugger management
  use {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufRead",
    disable = not O.plugin.dap_install.active,
  }

  -- LANGUAGE SPECIFIC GOES HERE
  use {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require "lv-vimtex"
    end,
  }

  -- Rust tools
  -- TODO: use lazy loading maybe?
  use {
    "simrat39/rust-tools.nvim",
    disable = not O.lang.rust.rust_tools.active,
  }

  -- Elixir
  use { "elixir-editors/vim-elixir", ft = { "elixir", "eelixir", "euphoria3" } }

  -- Javascript / Typescript
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  }
  -- use {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = {
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --   },
  --   config = function()
  --     require("null-ls").setup()
  --   end,
  -- }

  -- Pretty parentheses
  use {
    "p00f/nvim-ts-rainbow",
    disable = not O.plugin.ts_rainbow.active,
  }

  -- Autotags <div>|</div>
  use {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    disable = not O.plugin.ts_autotag.active,
  }

  -- Custom semantic text objects
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    disable = not O.plugin.ts_textobjects.active,
  }

  -- Smart text objects
  use {
    "RRethy/nvim-treesitter-textsubjects",
    disable = not O.plugin.ts_textsubjects.active,
  }

  -- Text objects using hint labels
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    event = "BufRead",
    disable = not O.plugin.ts_hintobjects.active,
  }

  for _, plugin in pairs(O.user_plugins) do
    packer.use(plugin)
  end
end)
