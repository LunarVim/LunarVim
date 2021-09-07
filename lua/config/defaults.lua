local home_dir = vim.loop.os_homedir()

vim.cmd [[ set spellfile=~/.config/lvim/spell/en.utf-8.add ]]

return {
  leader = "space",
  colorscheme = "onedarker",
  line_wrap_cursor_movement = true,
  transparent_window = false,
  format_on_save = true,
  vsnip_dir = home_dir .. "/.config/snippets",
  database = { save_location = "~/.config/lunarvim_db", auto_execute = 1 },
  keys = {},

  builtins = {},

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

  lsp = {},

  plugins = {
    -- use config.lua for this not put here
  },

  autocommands = {},
}
