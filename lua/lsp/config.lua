local schemas = nil
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
  schemas = jsonls_settings.get_default_schemas()
end

local Config = {
  completion = {
    item_kind = {
      "   (Text) ",
      "   (Method)",
      "   (Function)",
      "   (Constructor)",
      " ﴲ  (Field)",
      "[] (Variable)",
      "   (Class)",
      " ﰮ  (Interface)",
      "   (Module)",
      " 襁 (Property)",
      "   (Unit)",
      "   (Value)",
      " 練 (Enum)",
      "   (Keyword)",
      "   (Snippet)",
      "   (Color)",
      "   (File)",
      "   (Reference)",
      "   (Folder)",
      "   (EnumMember)",
      " ﲀ  (Constant)",
      " ﳤ  (Struct)",
      "   (Event)",
      "   (Operator)",
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
  lang = {
    asm = {},
    beancount = {
      client = {
        name = "beancount",
        setup = {
          cmd = { "beancount-langserver" },
        },
      },
    },
    bicep = {
      client = {
        name = "bicep",
        setup = {
          cmd = {
            "dotnet",
            DATA_PATH .. "/lspinstall/bicep/Bicep.LangServer.dll",
          },
          filetypes = { "bicep" },
        },
      },
    },
    c = {
      client = {
        name = "clangd",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
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
      client = {
        name = "clangd",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
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
      client = {
        name = "crystalline",
        setup = {
          cmd = { "crystalline" },
        },
      },
    },
    cs = {
      client = {
        name = "omnisharp",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/csharp/omnisharp/run",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
          },
        },
      },
    },
    cmake = {
      client = {
        name = "cmake",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/cmake/venv/bin/cmake-language-server",
          },
        },
      },
    },
    clojure = {
      client = {
        name = "clojure_lsp",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/clojure/clojure-lsp",
          },
        },
      },
    },
    css = {
      client = {
        name = "cssls",
        setup = {
          cmd = {
            "node",
            DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
            "--stdio",
          },
        },
      },
    },
    less = {
      client = {
        name = "cssls",
        setup = {
          cmd = {
            "node",
            DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
            "--stdio",
          },
        },
      },
    },
    d = {
      client = {
        name = "serve_d",
        setup = {
          cmd = { "serve-d" },
        },
      },
    },
    dart = {
      client = {
        name = "dartls",
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
      client = {
        name = "dockerls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
            "--stdio",
          },
        },
      },
    },
    elixir = {
      client = {
        name = "elixirls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh",
          },
        },
      },
    },
    elm = {
      client = {
        name = "elmls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-language-server",
          },
          -- init_options = {
          -- elmAnalyseTrigger = "change",
          -- elmFormatPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-format",
          -- elmPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/",
          -- elmTestPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-test",
          -- },
        },
      },
    },
    erlang = {
      client = {
        name = "erlangls",
        setup = {
          cmd = {
            "erlang_ls",
          },
        },
      },
    },
    emmet = { active = false },
    fish = {},
    fortran = {
      client = {
        name = "fortls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/fortran/venv/bin/fortls",
          },
        },
      },
    },
    go = {
      client = {
        name = "gopls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/go/gopls",
          },
        },
      },
    },
    graphql = {
      client = {
        name = "graphql",
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
      client = {
        name = "hls",
        setup = {
          cmd = { DATA_PATH .. "/lspinstall/haskell/hls" },
        },
      },
    },
    html = {
      client = {
        name = "html",
        setup = {
          cmd = {
            "node",
            DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
            "--stdio",
          },
        },
      },
    },
    java = {
      client = {
        name = "jdtls",
        setup = {
          cmd = { DATA_PATH .. "/lspinstall/java/jdtls.sh" },
        },
      },
    },
    json = {
      client = {
        name = "jsonls",
        setup = {
          cmd = {
            "node",
            DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
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
      client = {
        name = "julials",
        setup = {
          {
            "julia",
            "--startup-file=no",
            "--history-file=no",
            -- vim.fn.expand "~/.config/nvim/lua/lsp/julia/run.jl",
            CONFIG_PATH .. "/utils/julia/run.jl",
          },
        },
      },
    },
    kotlin = {
      client = {
        name = "kotlin_language_server",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/kotlin/server/bin/kotlin-language-server",
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
      client = {
        name = "sumneko_lua",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
            "-E",
            DATA_PATH .. "/lspinstall/lua/main.lua",
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
                  [vim.fn.expand "~/.local/share/lunarvim/lvim/lua"] = true,
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
    nginx = {},
    perl = {},
    solidity = {
      client = {
        name = "solang",
        setup = {
          cmd = { "solang", "--language-server" },
        },
      },
    },
    sql = {
      client = {
        name = "sqls",
        setup = {
          cmd = { "sqls" },
        },
      },
    },
    php = {
      client = {
        name = "intelephense",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/php/node_modules/.bin/intelephense",
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
      client = {
        name = "puppet",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/puppet/puppet-editor-services/puppet-languageserver",
            "--stdio",
          },
        },
      },
    },
    javascript = {
      client = {
        name = "tsserver",
        setup = {
          cmd = {
            -- TODO:
            DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
            "--stdio",
          },
        },
      },
    },
    javascriptreact = {
      client = {
        name = "tsserver",
        setup = {
          cmd = {
            -- TODO:
            DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
            "--stdio",
          },
        },
      },
    },
    python = {
      client = {
        name = "pyright",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
            "--stdio",
          },
        },
      },
    },
    -- R -e 'install.packages("formatR",repos = "http://cran.us.r-project.org")'
    -- R -e 'install.packages("readr",repos = "http://cran.us.r-project.org")'
    r = {
      client = {
        name = "r_language_server",
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
      client = {
        name = "solargraph",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/ruby/solargraph/solargraph",
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
      client = {
        name = "rust_analyzer",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/rust/rust-analyzer",
          },
        },
      },
    },
    scala = {
      client = {
        name = "metals",
      },
    },
    sh = {
      client = {
        name = "bashls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
            "start",
          },
        },
      },
    },
    svelte = {
      client = {
        name = "svelte",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/svelte/node_modules/.bin/svelteserver",
            "--stdio",
          },
        },
      },
    },
    swift = {
      client = {
        name = "sourcekit",
        setup = {
          cmd = {
            "xcrun",
            "sourcekit-lsp",
          },
        },
      },
    },
    tailwindcss = {
      client = {
        active = false,
        name = "tailwindcss",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/tailwindcss/node_modules/.bin/tailwindcss-language-server",
            "--stdio",
          },
        },
      },
    },
    terraform = {
      client = {
        name = "terraformls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/terraform/terraform-ls",
            "serve",
          },
        },
      },
    },
    tex = {
      client = {
        name = "texlab",
        setup = {
          cmd = { DATA_PATH .. "/lspinstall/latex/texlab" },
        },
      },
    },
    typescript = {
      client = {
        name = "tsserver",
        setup = {
          cmd = {
            -- TODO:
            DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
            "--stdio",
          },
        },
      },
    },
    typescriptreact = {
      client = {
        name = "tsserver",
        setup = {
          cmd = {
            -- TODO:
            DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
            "--stdio",
          },
        },
      },
    },
    vim = {
      client = {
        name = "vimls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
            "--stdio",
          },
        },
      },
    },
    vue = {
      client = {
        name = "vuels",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/vue/node_modules/.bin/vls",
          },
          root_dir = function(fname)
            local util = require "lspconfig/util"
            return util.root_pattern "package.json"(fname)
              or util.root_pattern "vue.config.js"(fname)
              or vim.fn.getcwd()
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
      client = {
        name = "yamlls",
        setup = {
          cmd = {
            DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
            "--stdio",
          },
        },
      },
    },
    zig = {
      client = {
        name = "zls",
        setup = {
          cmd = {
            "zls",
          },
        },
      },
    },
    gdscript = {
      client = {
        name = "gdscript",
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
      client = {
        name = "powershell_es",
        setup = {
          bundle_path = "",
        },
      },
    },
    nix = {
      client = {
        name = "rnix",
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
  },
}

return Config
