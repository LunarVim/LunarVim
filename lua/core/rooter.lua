local M = {}

M.config = function()
  lvim.builtin.rooter = {
    active = true,
    on_config_done = nil,
  }
end

M.setup = function()
  vim.g.rooter_silent_chdir = 1
  if lvim.builtin.rooter.on_config_done then
    lvim.builtin.rooter.on_config_done()
  end
end

return M
