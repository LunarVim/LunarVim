local M = {}
M.config = function()
  lvim.builtin.numb = {
    active = true,
    on_config_done = nil,
    options = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    }
  }
end

M.setup = function()

  local status_ok, numb = pcall(require, "numb")
  if not status_ok then
    return
  end
  numb.setup(lvim.builtin.numb.options)

  if lvim.builtin.numb.on_config_done then
    lvim.builtin.numb.on_config_done()
  end
end

return M
