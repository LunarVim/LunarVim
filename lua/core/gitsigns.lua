local M = {}
M.config = function()
  O.plugin.gitsigns = {
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
    watch_index = { interval = 1000 },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
    use_decoration_api = false,
  }
end

M.setup = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end
  gitsigns.setup(O.plugin.gitsigns)
end

return M
