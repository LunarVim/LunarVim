local home_dir = vim.loop.os_homedir()
local utils = require "utils"

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
    -- FIXME: stop using hard-coded paths for LspInstall
    ls_install_prefix = vim.fn.stdpath "data" .. "/lspinstall",
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
