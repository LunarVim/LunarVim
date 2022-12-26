local M = {}
M.config = function()
  lvim.builtin.harpoon = {
    active = true,
    options = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = false,

      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,

      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = false,

      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,

      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { "harpoon" },

      -- set marks specific to each git branch inside git repository
      mark_branch = false,
    }
  }
end

M.setup = function()
  local harpoon_ok, harpoon = pcall(require, 'harpoon')
  if not harpoon_ok then
    return
  end
  harpoon.setup(lvim.builtin.harpoon.options)
end

return M
