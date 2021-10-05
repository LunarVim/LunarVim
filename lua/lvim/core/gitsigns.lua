local M = {}

M.config = function()
  lvim.builtin.gitsigns = {
    active = true,
    on_config_done = nil,
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "▎",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "契",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "契",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      numhl = false,
      linehl = false,
      keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
      },
      watch_gitdir = { interval = 1000 },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil, -- Use default
    },
  }
end

M.setup = function()
  local gitsigns = require "gitsigns"

  gitsigns.setup(lvim.builtin.gitsigns.opts)
  if lvim.builtin.gitsigns.on_config_done then
    lvim.builtin.gitsigns.on_config_done(gitsigns)
  end
end

return M
