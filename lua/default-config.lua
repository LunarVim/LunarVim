CONFIG_PATH = os.getenv "HOME" .. "/.local/share/lunarvim/lvim"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

-- TODO O -> lv
O = {
  -- TODO Loose options under opt
  keys = {
    leader_key = "space",
  },
  colorscheme = "spacegray",
  line_wrap_cursor_movement = true,
  transparent_window = false,
  format_on_save = true,
  lint_on_save = true,
  vsnip_dir = os.getenv "HOME" .. "/.config/snippets",
  database = { save_location = "~/.config/lunarvim_db", auto_execute = 1 },

  -- TODO why do we need this?
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

  plugins = {
    -- use lv-config.lua for this not put here
  },

  autocommands = {
    { "FileType", "qf", "set nobuflisted" },
  },

  -- TODO hide this
  formatters = {
    filetype = {},
  },

  -- TODO move all of this into lang specific files, only require when using
  lang = {

    csharp = {
      lsp = {
        path = DATA_PATH .. "/lspinstall/csharp/omnisharp/run",
      },
    },
    cmake = {
      formatter = {
        exe = "clang-format",
        args = {},
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server",
      },
    },
    clojure = {
      lsp = {
        path = DATA_PATH .. "/lspinstall/clojure/clojure-lsp",
      },
    },
    dart = {
      sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
      formatter = {
        exe = "dart",
        args = { "format" },
        stdin = true,
      },
    },
    docker = {
      lsp = {
        path = DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
      },
    },
    elixir = {
      formatter = {
        exe = "mix",
        args = { "format" },
        stdin = true,
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh",
      },
    },
    erlang = {
      lsp = {
        path = "erlang_ls",
      },
    },
    html = {
      linters = {
        "tidy",
        -- https://docs.errata.ai/vale/scoping#html
        "vale",
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
      },
    },
    python = {
      -- @usage can be flake8 or yapf
      formatter = {
        exe = "yapf",
        args = {},
        stdin = true,
      },
      linters = {
        "flake8",
        "pylint",
        "mypy",
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
      },
    },
    efm = {},
    emmet = { active = false },
    graphql = {
      lsp = {
        path = "graphql-lsp",
      },
    },
    go = {
      formatter = {
        exe = "gofmt",
        args = {},
        stdin = true,
      },
      linters = {
        "golangcilint",
        "revive",
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/go/gopls",
      },
    },
    sh = {
      -- @usage can be 'shellcheck'
      linter = "",
      -- @usage can be 'shfmt'
      formatter = {
        exe = "shfmt",
        args = { "-w" },
        stdin = false,
      },
      linters = { "shellcheck" },
      lsp = {
        path = DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
      },
    },
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
      lsp = {
        path = DATA_PATH .. "/lspinstall/terraform/terraform-ls",
      },
    },
    -- R -e 'install.packages("formatR",repos = "http://cran.us.r-project.org")'
    -- R -e 'install.packages("readr",repos = "http://cran.us.r-project.org")'
    r = {
      formatter = {
        exe = "R",
        args = {
          "--slave",
          "--no-restore",
          "--no-save",
          '-e "formatR::tidy_source(text=readr::read_file(file(\\"stdin\\")), arrow=FALSE)"',
        },
        stdin = true,
      },
    },
    ruby = {
      formatter = {
        exe = "rufo",
        args = { "-x" },
        stdin = true,
      },
      linters = { "ruby" },
      lsp = {
        path = DATA_PATH .. "/lspinstall/ruby/solargraph/solargraph",
      },
    },
    rust = {
      formatter = {
        exe = "rustfmt",
        args = { "--emit=stdout", "--edition=2018" },
        stdin = true,
      },
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/rust/rust-analyzer",
      },
    },
    svelte = {
      lsp = {
        path = DATA_PATH .. "/lspinstall/svelte/node_modules/.bin/svelteserver",
      },
    },
    swift = {
      formatter = {
        exe = "swiftformat",
        args = {},
        stdin = true,
      },
      lsp = {
        path = "sourcekit-lsp",
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
    yaml = {
      formatter = {
        exe = "prettier",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
        stdin = true,
      },
      lsp = {
        path = DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
      },
    },
    vim = {
      linters = { "vint" },
      lsp = {
        path = DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
      },
    },
    zig = {
      formatter = {
        exe = "zig",
        args = { "fmt" },
        stdin = false,
      },
      lsp = {
        path = "zls",
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
require("lang.css").config()
require("lang.elm").config()
require("lang.java").config()
require("lang.json").config()
require("lang.julia").config()
require("lang.kotlin").config()
require("lang.lua").config()
require("lang.php").config()
require("lang.scala").config()
require("lang.tex").config()
require("lang.vue").config()
