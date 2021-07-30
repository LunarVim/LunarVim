local M = {}

M.config = function()
  lvim.builtin.comment = {
    active = true,
    on_config_done = nil,
  }
end

M.setup = function()
  local status_ok, nvim_comment = pcall(require, "nvim_comment")
  if not status_ok then
    return
  end
  nvim_comment.setup()

  if lvim.builtin.comment.on_config_done then
    lvim.builtin.comment.on_config_done(nvim_comment)
  end

  return nvim_comment
end

return M
