local M = {}

M.config = function()
  lvim.builtin.lualine = {
    active = true,
    on_config_done = nil,
    config = {
      style = "lvim",
      options = {},
      sections = {},
      inactive_sections = {},
    },
  }
end

M.setup = function()
  require("core.lualine.styles").update()
  require("core.lualine.utils").validate_theme()

  local lualine = require "lualine"
  lualine.setup(lvim.builtin.lualine.config)

  if lvim.builtin.lualine.on_config_done then
    lvim.builtin.lualine.on_config_done(lualine)
  end
end

return M
