CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

O = {
  auto_close_tree = 0,
  auto_complete = true,
  colorscheme = "lunar",
  cursorline = true,
  format_on_save = true,
  hidden_files = true,
  hl_search = false,
  ignore_case = true,
  leader_key = "space",
  lushmode = false,
  number = true,
  nvim_tree_disable_netrw = 0,
  relative_number = true,
  shell = "bash",
  smart_case = true,
  timeoutlen = 100,
  transparent_window = false,
  vnsip_dir = vim.fn.stdpath "config" .. "/snippets",
  wrap_lines = false,

  -- @usage pass a table with your desired languages
  treesitter = {
    ensure_installed = "all",
    highlight = { enabled = true },
    -- The below is for treesitter hint textobjects plugin
    hint_labels = { "h", "j", "f", "d", "n", "v", "s", "l", "a" },
    ignore_install = { "haskell" },
    -- The below are for treesitter-textobjects plugin
    textobj_prefixes = {
      goto_previous = "[", -- Go to previous
      goto_next = "]", -- Go to next
      inner = "i", -- Select inside
      outer = "a", -- Selct around
      swap = "<leader>a", -- Swap with next
    },
    textobj_suffixes = {
      -- Start and End respectively for the goto keys
      -- for other keys it only uses the first
      ["block"] = { "k", "K" },
      ["call"] = { "c", "C" },
      ["class"] = { "m", "M" },
      ["comment"] = { "/", "?" },
      ["conditional"] = { "i", "I" },
      ["function"] = { "f", "F" },
      ["loop"] = { "l", "L" },
      ["parameter"] = { "a", "A" },
      ["statement"] = { "s", "S" },
    },
  },

  lsp = {
    popup_border = "single",
  },

  database = { auto_execute = 1, save_location = "~/.config/nvcode_db" },

  plugin = {
    -- Builtins
    colorizer = { active = false },
    dap_install = { active = false },
    dashboard = { active = false },
    debug = { active = false },
    diffview = { active = false },
    floatterm = { active = false },
    indent_line = { active = false },
    lush = { active = false },
    telescope_fzy = { active = false },
    telescope_project = { active = false },
    trouble = { active = false },
    ts_autotag = { active = false },
    ts_context_commentstring = { active = false },
    ts_hintobjects = { active = false },
    ts_playground = { active = false },
    ts_rainbow = { active = false },
    ts_textobjects = { active = false },
    ts_textsubjects = { active = false },
    sanegx = { active = false },
    symbol_outline = { active = false },
    zen = { active = false },
  },

  custom_plugins = {
    -- use lv-config.lua for this not put here
  },

  user_autocommands = {
    { "FileType", "qf", "set nobuflisted" },
  },

  lang = {
    clang = {
      cross_file_rename = true,
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
      header_insertion = "never",
    },
    cmake = {},
    css = {
      virtual_text = true,
    },
    dart = {
      sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    },
    docker = {},
    efm = {},
    elixir = {},
    elm = {},
    emmet = { active = true },
    go = {},
    graphql = {},
    html = {},
    java = {},
    json = {
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
    },
    kotlin = {},
    latex = {},
    lua = {
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
    },
    php = {
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
      environment = {
        php_version = "7.4",
      },
      filetypes = { "php", "phtml" },
    },
    python = {
      analysis = {
        auto_search_paths = true,
        type_checking = "basic",
        use_library_code_types = true,
      },
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
      isort = false,
      linter = "",
    },
    ruby = {
      diagnostics = {
        signs = true,
        underline = true,
        virtualtext = { prefix = "", spacing = 0 },
      },
      filetypes = { "erb", "rakefile", "rb", "ruby" },
    },
    rust = {
      diagnostics = {
        virtual_text = { prefix = "", spacing = 0 },
        signs = true,
        underline = true,
      },
      linter = "",
      rust_tools = {
        active = false,
      },
    },
    sh = {
      -- @usage can be 'shfmt'
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
      -- @usage can be 'shellcheck'
      linter = "",
    },
    svelte = {},
    tailwindcss = {
      active = false,
      filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "scss",
        "typescript",
        "typescriptreact",
      },
    },
    terraform = {},
    tsserver = {
      diagnostics = {
        signs = true,
        underline = true,
        virtual_text = { prefix = "", spacing = 0 },
      },
      -- @usage can be 'eslint'
      linter = "",
    },
    vim = {},
    yaml = {},
  },

  dashboard = {
    custom_header = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣾⠿⠿⠟⠛⠛⠛⠛⠿⠿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠂⠉⠉⠉⠉⢩⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⢰⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⡀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⢀⣸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡧⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠈⠁⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠉⠢⠤⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡟⠈⠑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠒⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⢀⣣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠒⠢⠤⠄⣀⣀⠀⠀⠀⢠⣿⡟⠀⠀⠀⣺⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣿⠇⠀⠀⠀⠀⠀⣤⡄⠀⠀⢠⣤⡄⠀⢨⣭⣠⣤⣤⣤⡀⠀⠀⢀⣤⣤⣤⣤⡄⠀⠀⠀⣤⣄⣤⣤⣤⠀⠀⣿⣯⠉⠉⣿⡟⠀⠈⢩⣭⣤⣤⠀⠀⠀⠀⣠⣤⣤⣤⣄⣤⣤",
      "⢠⣿⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⣸⣿⠁⠀⣿⣿⠉⠀⠈⣿⡇⠀⠀⠛⠋⠀⠀⢹⣿⠀⠀⠀⣿⠏⠀⠸⠿⠃⠀⣿⣿⠀⣰⡟⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⣿⡟⢸⣿⡇⢀⣿",
      "⣸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⣿⡟⠀⢠⣿⡇⠀⠀⢰⣿⡇⠀⣰⣾⠟⠛⠛⣻⡇⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⢻⣿⢰⣿⠀⠀⠀⠀⠀⠀⣾⡇⠀⠀⠀⢸⣿⠇⢸⣿⠀⢸⡏",
      "⣿⣧⣤⣤⣤⡄⠀⠘⣿⣤⣤⡤⣿⠇⠀⢸⣿⠁⠀⠀⣼⣿⠀⠀⢿⣿⣤⣤⠔⣿⠃⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⠋⠀⠀⠀⢠⣤⣤⣿⣥⣤⡄⠀⣼⣿⠀⣸⡏⠀⣿⠃",
      "⠉⠉⠉⠉⠉⠁⠀⠀⠈⠉⠉⠀⠉⠀⠀⠈⠉⠀⠀⠀⠉⠉⠀⠀⠀⠉⠉⠁⠈⠉⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠉⠁⠀⠉⠁⠀⠉⠀",
    },
    footer = { "chrisatmachine.com" },
  },
}
