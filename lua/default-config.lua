CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

O = {
  leader_key = "space",
  colorscheme = "spacegray",
  line_wrap_cursor_movement = true,
  transparent_window = false,
  format_on_save = true,
  vsnip_dir = vim.fn.stdpath "config" .. "/snippets",

  default_options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    colorcolumn = "99999", -- fixes indentline for now
    completeopt = { "menuone", "noselect" },
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    guifont = "monospace:h17", -- the font used in graphical neovim applications
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = false, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- set the title of window to the value of the titlestring
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    undodir = CACHE_PATH .. "/undo", -- set an undo directory
    undofile = true, -- enable persisten undo
    updatetime = 300, -- faster completion
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = false, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    spell = false,
    spelllang = "en",
    scrolloff = 8, -- is one of my fav
  },

  plugin = {},

  -- TODO: refactor for tree
  auto_close_tree = 0,
  nvim_tree_disable_netrw = 0,

  lsp = {
    document_highlight = true,
    popup_border = "single",
  },

  database = { save_location = "~/.config/lunarvim_db", auto_execute = 1 },

  -- TODO: just using mappings (leader mappings)
  user_which_key = {},

  user_plugins = {
    -- use lv-config.lua for this not put here
  },

  user_autocommands = {
    { "FileType", "qf", "set nobuflisted" },
  },

  formatters = {
    filetype = {},
  },

  -- TODO move all of this into lang specific files, only require when using
  lang = {
    cmake = {
      formatter = {
        exe = "clang-format",
        args = {},
      },
    },
    clang = {
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      cross_file_rename = true,
      header_insertion = "never",
      filetypes = { "c", "cpp", "objc" },
      formatter = {
        exe = "clang-format",
        args = {},
      },
    },
    css = {
      virtual_text = true,
    },
    dart = {
      sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
      formatter = {
        exe = "dart",
        args = { "format" },
      },
    },
    docker = {},
    efm = {},
    elm = {},
    emmet = { active = false },
    elixir = {},
    graphql = {},
    go = {
      formatter = {
        exe = "gofmt",
        args = {},
      },
    },
    html = {},
    java = {
      java_tools = {
        active = false,
      },
      formatter = {
        exe = "prettier",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
      },
    },
    json = {
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      formatter = {
        exe = "python",
        args = { "-m", "json.tool" },
      },
    },
    kotlin = {},
    latex = {
      auto_save = false,
      ignore_errors = {},
    },
    lua = {
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      formatter = {
        exe = "stylua",
        args = {},
        stdin = false,
      },
    },
    php = {
      format = {
        format = {
          default = "psr12",
        },
      },
      environment = {
        php_version = "7.4",
      },
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      filetypes = { "php", "phtml" },
      formatter = {
        exe = "phpcbf",
        args = { "--standard=PSR12", vim.api.nvim_buf_get_name(0) },
        stdin = false,
      },
    },
    python = {
      -- @usage can be flake8 or yapf
      linter = "",
      isort = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      analysis = {
        type_checking = "basic",
        auto_search_paths = true,
        use_library_code_types = true,
      },
      formatter = {
        exe = "yapf",
        args = {},
      },
    },
    ruby = {
      diagnostics = {
        virtualtext = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      filetypes = { "rb", "erb", "rakefile", "ruby" },
      formatter = {
        exe = "rufo",
        args = { "-x" },
      },
    },
    rust = {
      rust_tools = {
        active = false,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>", -- prefix for all the other hints (type, chaining)
      },
      -- @usage can be clippy
      formatter = {
        exe = "rustfmt",
        args = { "--emit=stdout", "--edition=2018" },
      },
      linter = "",
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
    sh = {
      -- @usage can be 'shellcheck'
      linter = "",
      -- @usage can be 'shfmt'
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      formatter = {
        exe = "shfmt",
        args = { "-w" },
        stdin = false,
      },
    },
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
    terraform = {
      formatter = {
        exe = "terraform",
        args = { "fmt" },
        stdin = false,
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
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
      },
    },
    vim = {},
    yaml = {
      formatter = {
        exe = "prettier",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
      },
    },
  },
}

require "core.status_colors"
require("core.gitsigns").config()
require("core.compe").config()
require("core.dashboard").config()
require("core.dap").config()
require("core.floatterm").config()
require("core.zen").config()
require("core.telescope").config()
require("core.treesitter").config()
require("core.which-key").config()
