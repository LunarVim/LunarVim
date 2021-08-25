local M = {}

function M.config()
  lvim.builtin.comment = {
    active = true,
    on_config_done = nil,
    config = {},
  }
end

function M.setup()
  local nvim_comment = require "nvim_comment"

  nvim_comment.setup(lvim.builtin.comment.config)
  if lvim.builtin.comment.on_config_done then
    lvim.builtin.comment.on_config_done(nvim_comment)
  end
end

return M
