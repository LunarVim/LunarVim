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
  plugins = {
    -- use config.lua for this not put here
  },
  ensure_configured = {
    "lua",
    "javascript",
    "html",
    "css",
    "python",
    "java",
    "typescript",
    "csharp",
    "bash",
    "cpp",
    "php",
    "c",
    "go",
    "kotlin",
    "rust",
    "ruby",
    "julia",
  },

  autocommands = {},
  lang = {},
}
