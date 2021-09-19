local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "vuels",
    setup = {
      cmd = {
        lvim.lsp.ls_install_prefix .. "/vue/node_modules/.bin/vls",
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
}
return opts
