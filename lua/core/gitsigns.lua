local M = {}

M.opts = {
  signs = {
    -- TODO: add hl to colorscheme
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
  watch_index = { interval = 1000 },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  use_decoration_api = false,
}


M.config = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end
  require('lv-utils').fetch_overrides(O.plugin.gitsigns, M.opts)
  gitsigns.setup(O.plugin.gitsigns)
end

return M
