CONFIG_PATH = os.getenv "HOME" .. "/.local/share/lunarvim/lvim"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

O = {
  keys = {
    leader_key = "space",
  },
  colorscheme = "spacegray",
  line_wrap_cursor_movement = true,
  transparent_window = false,
  format_on_save = true,
  lint_on_save = true,
  vsnip_dir = os.getenv "HOME" .. "/.config/snippets",

  lsp = {
    diagnostics = {
      virtual_text = {
        prefix = "",
        spacing = 0,
      },
      signs = true,
      underline = true,
    },
    document_highlight = true,
    popup_border = "single",
    default_keybinds = true,
    on_attach_callback = nil,
  },

  plugin = {
    lspinstall = {},
    telescope = {},
    compe = {},
    autopairs = {},
    treesitter = {},
    formatter = {},
    lint = {},
    nvimtree = {},
    gitsigns = {},
    which_key = {},
    comment = {},
    rooter = {},
    galaxyline = {},
    bufferline = {},
    dap = {},
    dashboard = {},
    terminal = {},
  },

  database = { save_location = "~/.config/lunarvim_db", auto_execute = 1 },

  plugins = {
    -- use lv-config.lua for this not put here
  },

  autocommands = {
    { "FileType", "qf", "set nobuflisted" },
  },

  formatters = {
    filetype = {},
  },

  -- TODO move all of this into lang specific files, only require when using
  lang = {
    efm = {},
    emmet = { active = false },
    svelte = {},
    tailwindcss = {
      active = false,
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    },
    tsserver = {
      -- @usage can be 'eslint' or 'eslint_d'
      linter = "",
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      formatter = {
        exe = "prettier",
        args = {},
      },
    },
  },
}

require("core.which-key").config()
require "core.status_colors"
require("core.gitsigns").config()
require("core.compe").config()
require("core.dashboard").config()
require("core.dap").config()
require("core.terminal").config()
require("core.telescope").config()
require("core.treesitter").config()
require("core.nvimtree").config()

require("lang.clang").config()
require("lang.clojure").config()
require("lang.cmake").config()
require("lang.cs").config()
require("lang.css").config()
require("lang.dart").config()
require("lang.dockerfile").config()
require("lang.elixir").config()
require("lang.elm").config()
require("lang.go").config()
require("lang.graphql").config()
require("lang.html").config()
require("lang.java").config()
require("lang.json").config()
require("lang.julia").config()
require("lang.kotlin").config()
require("lang.lua").config()
require("lang.php").config()
require("lang.python").config()
require("lang.r").config()
require("lang.ruby").config()
require("lang.rust").config()
require("lang.sh").config()
require("lang.scala").config()
require("lang.svelte").config()
require("lang.swift").config()
require("lang.terraform").config()
require("lang.tex").config()
require("lang.vim").config()
require("lang.vue").config()
require("lang.yaml").config()
require("lang.zig").config()
require("lang.zsh").config()
