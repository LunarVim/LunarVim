local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {
      style = "lvim",
      options = {},
      sections = {},
      inactive_sections = {},
    },
  },
}

function M:setup(config)
  config:extend_with(self.defaults)
end

function M:config()
  require("core.lualine.styles").update()
  require("core.lualine.utils").validate_theme()

  local lualine = require "lualine"
  lualine.setup(lvim.builtins.lualine.config)

  if lvim.builtins.lualine.on_config_done then
    lvim.builtins.lualine.on_config_done(lualine)
  end
end

return M
