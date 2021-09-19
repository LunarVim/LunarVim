local home_dir = vim.loop.os_homedir()
local utils = require "utils"
-- FIXME: stop using hard-coded paths for LspInstall
local ls_install_prefix = vim.fn.stdpath "data" .. "/lspinstall"

lvim = {
  leader = "space",
  colorscheme = "onedarker",
  line_wrap_cursor_movement = true,
  transparent_window = false,
  format_on_save = true,
  vsnip_dir = utils.join_paths(home_dir, ".config", "snippets"),
  database = { save_location = utils.join_paths(home_dir, ".config", "lunarvim_db"), auto_execute = 1 },
  keys = {},

  builtin = {},

  log = {
    ---@usage can be { "trace", "debug", "info", "warn", "error", "fatal" },
    level = "warn",
    viewer = {
      ---@usage this will fallback on "less +F" if not found
      cmd = "lnav",
      layout_config = {
        ---@usage direction = 'vertical' | 'horizontal' | 'window' | 'float',
        direction = "horizontal",
        open_mapping = "",
        size = 40,
        float_opts = {},
      },
    },
  },

  lsp = {
    completion = {
      item_kind = {
        "   (Text) ",
        "   (Method)",
        "   (Function)",
        "   (Constructor)",
        "   (Field)",
        "   (Variable)",
        "   (Class)",
        " ﰮ  (Interface)",
        "   (Module)",
        "   (Property)",
        " 塞 (Unit)",
        "   (Value)",
        " 練 (Enum)",
        "   (Keyword)",
        "   (Snippet)",
        "   (Color)",
        "   (File)",
        "   (Reference)",
        "   (Folder)",
        "   (EnumMember)",
        " ﲀ  (Constant)",
        "   (Struct)",
        "   (Event)",
        "   (Operator)",
        "   (TypeParameter)",
      },
    },
    diagnostics = {
      signs = {
        active = true,
        values = {
          { name = "LspDiagnosticsSignError", text = "" },
          { name = "LspDiagnosticsSignWarning", text = "" },
          { name = "LspDiagnosticsSignHint", text = "" },
          { name = "LspDiagnosticsSignInformation", text = "" },
        },
      },
      virtual_text = {
        prefix = "",
        spacing = 0,
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    },
    override = {},
    document_highlight = true,
    popup_border = "single",
    on_attach_callback = nil,
    on_init_callback = nil,
    null_ls = {
      setup = {},
    },
  },

  plugins = {
    -- use config.lua for this not put here
  },

  autocommands = {},
}

local schemas = nil
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
  schemas = jsonls_settings.get_default_schemas()
end

-- TODO move all of this into lang specific files, only require when using
lvim.lang = {
  asm = {
    formatters = {
      -- {
      --   exe = "asmfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "",
      setup = {},
    },
  },
  beancount = {
    formatters = {
      -- {
      --   exe = "bean_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "beancount",
      setup = {
        cmd = { "beancount-langserver" },
      },
    },
  },
  bicep = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "bicep",
      setup = {
        cmd = {
          "dotnet",
          ls_install_prefix .. "/bicep/Bicep.LangServer.dll",
        },
        filetypes = { "bicep" },
      },
    },
  },
  c = {
    formatters = {
      -- {
      --   exe = "clang_format",
      --   args = {},
      -- },
      -- {
      --   exe = "uncrustify",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          ls_install_prefix .. "/cpp/clangd/bin/clangd",
          "--background-index",
          "--header-insertion=never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*",
        },
      },
    },
  },
  cpp = {
    formatters = {
      -- {
      --   exe = "clang_format",
      --   args = {},
      -- },
      -- {
      --   exe = "uncrustify",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "clangd",
      setup = {
        cmd = {
          ls_install_prefix .. "/cpp/clangd/bin/clangd",
          "--background-index",
          "--header-insertion=never",
          "--cross-file-rename",
          "--clang-tidy",
          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*",
        },
      },
    },
  },
  crystal = {
    formatters = {
      -- {
      --   exe = "crystal_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "crystalline",
      setup = {
        cmd = { "crystalline" },
      },
    },
  },
  cs = {
    formatters = {
      -- {
      --   exe = "clang_format ",
      --   args = {},
      -- },
      -- {
      --   exe = "uncrustify",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "omnisharp",
      setup = {
        cmd = {
          ls_install_prefix .. "/csharp/omnisharp/run",
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        },
      },
    },
  },
  cmake = {
    formatters = {
      -- {
      --   exe = "cmake_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "cmake",
      setup = {
        cmd = {
          ls_install_prefix .. "/cmake/venv/bin/cmake-language-server",
        },
      },
    },
  },
  clojure = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "clojure_lsp",
      setup = {
        cmd = {
          ls_install_prefix .. "/clojure/clojure-lsp",
        },
      },
    },
  },
  css = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "cssls",
      setup = {
        cmd = {
          "node",
          ls_install_prefix .. "/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
          "--stdio",
        },
      },
    },
  },
  less = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "cssls",
      setup = {
        cmd = {
          "node",
          ls_install_prefix .. "/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
          "--stdio",
        },
      },
    },
  },
  d = {
    formatters = {
      -- {
      --   exe = "dfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "serve_d",
      setup = {
        cmd = { "serve-d" },
      },
    },
  },
  dart = {
    formatters = {
      -- {
      --   exe = "dart_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "dartls",
      setup = {
        cmd = {
          "dart",
          "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
          "--lsp",
        },
      },
    },
  },
  dockerfile = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "dockerls",
      setup = {
        cmd = {
          ls_install_prefix .. "/dockerfile/node_modules/.bin/docker-langserver",
          "--stdio",
        },
      },
    },
  },
  elixir = {
    formatters = {
      -- {
      --   exe = "mix",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "elixirls",
      setup = {
        cmd = {
          ls_install_prefix .. "/elixir/elixir-ls/language_server.sh",
        },
      },
    },
  },
  elm = {
    formatters = {
      -- {
      --   exe = "elm_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "elmls",
      setup = {
        cmd = {
          ls_install_prefix .. "/elm/node_modules/.bin/elm-language-server",
        },
        -- init_options = {
        -- elmAnalyseTrigger = "change",
        -- elmFormatPath = ls_install_prefix .. "/elm/node_modules/.bin/elm-format",
        -- elmPath = ls_install_prefix .. "/elm/node_modules/.bin/",
        -- elmTestPath = ls_install_prefix .. "/elm/node_modules/.bin/elm-test",
        -- },
      },
    },
  },
  erlang = {
    formatters = {
      -- {
      --   exe = "erlfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "erlangls",
      setup = {
        cmd = {
          "erlang_ls",
        },
      },
    },
  },
  emmet = { active = false },
  fish = {
    formatters = {
      -- {
      --   exe = "fish_indent",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "",
      setup = {},
    },
  },
  fortran = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "fortls",
      setup = {
        cmd = {
          ls_install_prefix .. "/fortran/venv/bin/fortls",
        },
      },
    },
  },
  go = {
    formatters = {
      -- {
      --   exe = "gofmt",
      --   args = {},
      -- },
      -- {
      --   exe = "goimports",
      --   args = {},
      -- },
      -- {
      --   exe = "gofumpt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "gopls",
      setup = {
        cmd = {
          ls_install_prefix .. "/go/gopls",
        },
      },
    },
  },
  graphql = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "graphql",
      setup = {
        cmd = {
          "graphql-lsp",
          "server",
          "-m",
          "stream",
        },
      },
    },
  },
  haskell = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "hls",
      setup = {
        cmd = { ls_install_prefix .. "/haskell/hls" },
      },
    },
  },
  html = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "html",
      setup = {
        cmd = {
          "node",
          ls_install_prefix .. "/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
          "--stdio",
        },
      },
    },
  },
  java = {
    formatters = {
      -- {
      --   exe = "clang_format",
      --   args = {},
      -- },
      -- {
      --   exe = "uncrustify",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "jdtls",
      setup = {
        cmd = { ls_install_prefix .. "/java/jdtls.sh" },
      },
    },
  },
  json = {
    formatters = {
      -- {
      --   exe = "json_tool",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "jsonls",
      setup = {
        cmd = {
          "node",
          ls_install_prefix .. "/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
          "--stdio",
        },
        settings = {
          json = {
            schemas = schemas,
            --   = {
            --   {
            --     fileMatch = { "package.json" },
            --     url = "https://json.schemastore.org/package.json",
            --   },
            -- },
          },
        },
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
            end,
          },
        },
      },
    },
  },
  julia = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "julials",
      setup = {
        {
          "julia",
          "--startup-file=no",
          "--history-file=no",
          -- self.runtime_dir .. "lvim/utils/julia/run.jl",
        },
      },
    },
  },
  kotlin = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "kotlin_language_server",
      setup = {
        cmd = {
          ls_install_prefix .. "/kotlin/server/bin/kotlin-language-server",
        },
        root_dir = function(fname)
          local util = require "lspconfig/util"

          local root_files = {
            "settings.gradle", -- Gradle (multi-project)
            "settings.gradle.kts", -- Gradle (multi-project)
            "build.xml", -- Ant
            "pom.xml", -- Maven
          }

          local fallback_root_files = {
            "build.gradle", -- Gradle
            "build.gradle.kts", -- Gradle
          }
          return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(unpack(fallback_root_files))(fname)
        end,
      },
    },
  },
  lua = {
    formatters = {
      -- {
      --   exe = "stylua",
      --   args = {},
      -- },
      -- {
      --   exe = "lua_format",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "sumneko_lua",
      setup = {
        cmd = {
          ls_install_prefix .. "/lua/sumneko-lua-language-server",
          "-E",
          ls_install_prefix .. "/lua/main.lua",
        },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "lvim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [require("utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 1000,
            },
          },
        },
      },
    },
  },
  nginx = {
    formatters = {
      -- {
      --   exe = "nginx_beautifier",
      --   args = {
      --     provider = "",
      --     setup = {},
      --   },
      -- },
    },
    linters = {},
    lsp = {},
  },
  perl = {
    formatters = {
      -- {
      --   exe = "perltidy",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "",
      setup = {},
    },
  },
  solidity = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "solang",
      setup = {
        cmd = { "solang", "--language-server" },
      },
    },
  },
  sql = {
    formatters = {
      -- {
      --   exe = "sqlformat",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "sqls",
      setup = {
        cmd = { "sqls" },
      },
    },
  },
  php = {
    formatters = {
      -- {
      --   exe = "phpcbf",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "intelephense",
      setup = {
        cmd = {
          ls_install_prefix .. "/php/node_modules/.bin/intelephense",
          "--stdio",
        },
        filetypes = { "php", "phtml" },
        settings = {
          intelephense = {
            environment = {
              phpVersion = "7.4",
            },
          },
        },
      },
    },
  },
  puppet = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "puppet",
      setup = {
        cmd = {
          ls_install_prefix .. "/puppet/puppet-editor-services/puppet-languageserver",
          "--stdio",
        },
      },
    },
  },
  javascript = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier_d_slim",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    -- @usage can be {"eslint"} or {"eslint_d"}
    linters = {},
    lsp = {
      provider = "tsserver",
      setup = {
        cmd = {
          -- TODO:
          ls_install_prefix .. "/typescript/node_modules/.bin/typescript-language-server",
          "--stdio",
        },
      },
    },
  },
  javascriptreact = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier_d_slim",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "tsserver",
      setup = {
        cmd = {
          -- TODO:
          ls_install_prefix .. "/typescript/node_modules/.bin/typescript-language-server",
          "--stdio",
        },
      },
    },
  },
  python = {
    formatters = {
      -- {
      --   exe = "yapf",
      --   args = {},
      -- },
      -- {
      --   exe = "isort",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "pyright",
      setup = {
        cmd = {
          ls_install_prefix .. "/python/node_modules/.bin/pyright-langserver",
          "--stdio",
        },
      },
    },
  },
  -- R -e 'install.packages("formatR",repos = "http://cran.us.r-project.org")'
  -- R -e 'install.packages("readr",repos = "http://cran.us.r-project.org")'
  r = {
    formatters = {
      -- {
      --   exe = "format_r",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "r_language_server",
      setup = {
        cmd = {
          "R",
          "--slave",
          "-e",
          "languageserver::run()",
        },
      },
    },
  },
  ruby = {
    formatters = {
      -- {
      --   exe = "rufo",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "solargraph",
      setup = {
        cmd = {
          ls_install_prefix .. "/ruby/solargraph/solargraph",
          "stdio",
        },
        filetypes = { "ruby" },
        init_options = {
          formatting = true,
        },
        root_dir = function(fname)
          local util = require("lspconfig").util
          return util.root_pattern("Gemfile", ".git")(fname)
        end,
        settings = {
          solargraph = {
            diagnostics = true,
          },
        },
      },
    },
  },
  rust = {
    formatters = {
      -- {
      --   exe = "rustfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "rust_analyzer",
      setup = {
        cmd = {
          ls_install_prefix .. "/rust/rust-analyzer",
        },
      },
    },
  },
  scala = {
    formatters = {
      -- {
      --   exe = "scalafmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "metals",
      setup = {},
    },
  },
  sh = {
    formatters = {
      -- {
      --   exe = "shfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "bashls",
      setup = {
        cmd = {
          ls_install_prefix .. "/bash/node_modules/.bin/bash-language-server",
          "start",
        },
      },
    },
  },
  svelte = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "svelte",
      setup = {
        cmd = {
          ls_install_prefix .. "/svelte/node_modules/.bin/svelteserver",
          "--stdio",
        },
      },
    },
  },
  swift = {
    formatters = {
      -- {
      --   exe = "swiftformat",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "sourcekit",
      setup = {
        cmd = {
          "xcrun",
          "sourcekit-lsp",
        },
      },
    },
  },
  tailwindcss = {
    lsp = {
      active = false,
      provider = "tailwindcss",
      setup = {
        cmd = {
          ls_install_prefix .. "/tailwindcss/node_modules/.bin/tailwindcss-language-server",
          "--stdio",
        },
      },
    },
  },
  terraform = {
    formatters = {
      -- {
      --   exe = "terraform_fmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "terraformls",
      setup = {
        cmd = {
          ls_install_prefix .. "/terraform/terraform-ls",
          "serve",
        },
      },
    },
  },
  tex = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "texlab",
      setup = {
        cmd = { ls_install_prefix .. "/latex/texlab" },
      },
    },
  },
  typescript = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier_d_slim",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "tsserver",
      setup = {
        cmd = {
          -- TODO:
          ls_install_prefix .. "/typescript/node_modules/.bin/typescript-language-server",
          "--stdio",
        },
      },
    },
  },
  typescriptreact = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier_d_slim",
      --   args = {},
      -- },
    },
    -- @usage can be {"eslint"} or {"eslint_d"}
    linters = {},
    lsp = {
      provider = "tsserver",
      setup = {
        cmd = {
          -- TODO:
          ls_install_prefix .. "/typescript/node_modules/.bin/typescript-language-server",
          "--stdio",
        },
      },
    },
  },
  vim = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "vimls",
      setup = {
        cmd = {
          ls_install_prefix .. "/vim/node_modules/.bin/vim-language-server",
          "--stdio",
        },
      },
    },
  },
  vue = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
      -- {
      --   exe = "prettier_d_slim",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "vuels",
      setup = {
        cmd = {
          ls_install_prefix .. "/vue/node_modules/.bin/vls",
        },
        root_dir = function(fname)
          local util = require "lspconfig/util"
          return util.root_pattern "package.json"(fname) or util.root_pattern "vue.config.js"(fname) or vim.fn.getcwd()
        end,
        init_options = {
          config = {
            vetur = {
              completion = {
                autoImport = true,
                tagCasing = "kebab",
                useScaffoldSnippets = true,
              },
              useWorkspaceDependencies = true,
              validation = {
                script = true,
                style = true,
                template = true,
              },
            },
          },
        },
      },
    },
  },
  yaml = {
    formatters = {
      -- {
      --   exe = "prettier",
      --   args = {},
      -- },
      -- {
      --   exe = "prettierd",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "yamlls",
      setup = {
        cmd = {
          ls_install_prefix .. "/yaml/node_modules/.bin/yaml-language-server",
          "--stdio",
        },
      },
    },
  },
  zig = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "zls",
      setup = {
        cmd = {
          "zls",
        },
      },
    },
  },
  gdscript = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "gdscript",
      setup = {
        cmd = {
          "nc",
          "localhost",
          "6008",
        },
      },
    },
  },
  ps1 = {
    formatters = {},
    linters = {},
    lsp = {
      provider = "powershell_es",
      setup = {
        bundle_path = "",
      },
    },
  },
  nix = {
    formatters = {
      -- {
      --   exe = "nixfmt",
      --   args = {},
      -- },
    },
    linters = {},
    lsp = {
      provider = "rnix",
      setup = {
        cmd = { "rnix-lsp" },
        filetypes = { "nix" },
        init_options = {},
        settings = {},
        root_dir = function(fname)
          local util = require "lspconfig/util"
          return util.root_pattern ".git"(fname) or vim.fn.getcwd()
        end,
      },
    },
  },
}
