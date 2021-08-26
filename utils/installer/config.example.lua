--[[
-- Linters should be filled in as strings with either
-- a global executable or a path to a local executable
]]
-- THIS IS AN EXAMPLE, FEEL FREE TO ADAPT IT TO YOUR NEEDS

-- [Manual] --
--
-- Key mapping configuration:
--  Key mappings modes:
--   insert_mode        = "i",
--   normal_mode        = "n",
--   select_mode        = "s",
--   term_mode          = "t",
--   visual_mode        = "v",
--   visual_block_mode  = "x",
--   command_mode       = "c",
--  Unmap a default keymapping
--   keys = {
--     normal_mode = {
--       ["<C-Up>"] = "",
--     },
--   }
--  Edit a default keymapping
--   keys = {
--     normal_mode = {
--       ["<C-q>"] = ":q<cr>",
--     },
--   }
--
-- Add new plugins
--  plugins = {
--    { "folke/tokyonight.nvim" },
--    {
--      "folke/trouble.nvim",
--      cmd = "TroubleToggle",
--    },
--  }
--
-- Plugin configuration:
--  'Built-in' Plugins
--    builtins.plugin_name.config = {...}
--    This table will be forwarded to the plugin at configuration time, for more information,
--    check the related plugin's documentation
--    Example:
--     builtins.which_key = {
--       config = {
--         mappings = {
--           ["P"] = { "<cmd>Telescope projects<CR>", "Projects" },
--           ["t"] = {
--             name = "+Trouble",
--             r = { "<cmd>Trouble lsp_references<cr>", "References" },
--             f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--             d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--             q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--             l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--             w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
--           },
--         },
--       },
--     }
--
--    On top of that, each plugin will call builtin.plugin_name.on_config_done if defined
--    Example:
--     Change Telescope navigation to use j and k for navigation
--     and n and p for history in both input and normal mode.
--     builtin.telescope.on_config_done = function()
--       local actions = require "telescope.actions"
--       -- for input mode
--       builtins.telescope.config.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--       builtins.telescope.config.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--       builtins.telescope.config.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--       builtins.telescope.config.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--       -- for normal mode
--       builtins.telescope.config.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--       builtins.telescope.config.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
--     end
--
-- Formatter / Linter configuration
--  Defining formatters overrides the LSP default formatting capabilities.
--  Available formatters and linters are listen in lvim's info panel (<leader>Li)
--  Example:
--   lua = {
--     formatters = {
--       {
--         exe = "stylua",
--       },
--     },
--     linters = {
--       {
--         exe = "luacheck",
--       },
--     },
--   },
--
-- LSP configuration
--  A custom on_attach function will be used for all the language servers
--  See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
--  lsp.on_attach_callback = function(client, bufnr)
--    local function buf_set_option(...)
--      vim.api.nvim_buf_set_option(bufnr, ...)
--    end
--    --Enable completion triggered by <c-x><c-o>
--    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--  end
--  you can overwrite the null_ls setup table (useful for setting the root_dir function)
--  lsp.null_ls.setup = {
--    root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
--  }
--  or if you need something more advanced
--  lsp.null_ls.setup.root_dir = function(fname)
--    if vim.bo.filetype == "javascript" then
--      return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--        or require("lspconfig/util").path.dirname(fname)
--    elseif vim.bo.filetype == "php" then
--      return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--    else
--      return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--    end
--  end
--
-- Autocommands configuration (https://neovim.io/doc/user/autocmd.html)
--  autocommands = {
--    custom_groups = {
--      { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
--    },
--  }

return {
  log = {
    level = "warn",
  },
  format_on_save = true,
  colorscheme = "onedarker",
  -- keymappings [view all the defaults by pressing <leader>Lk]
  leader = "space",

  keys = {
    normal_mode = {
      ["<C-s>"] = ":w<cr>",
    },
  },

  builtin = {
    dashboard = {
      active = true,
    },
    terminal = {
      active = true,
    },
    nvimtree = {
      config = {
        side = "left",
        show_icons = { git = 0 },
      },
    },

    treesitter = {
      config = {
        ensure_installed = "maintained",
        ignore_install = { "haskell" },
        highlight = { enabled = true },
      },
    },
  },
}
