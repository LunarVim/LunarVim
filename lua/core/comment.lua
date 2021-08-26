local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {},
  },
}

function M:setup(config)
  config:extend_with(self.defaults)
end

function M.config()
  local nvim_comment = require "nvim_comment"

  nvim_comment.setup(lvim.builtins.comment.config)
  if lvim.builtins.comment.on_config_done then
    lvim.builtins.comment.on_config_done(nvim_comment)
  end
end

return M
