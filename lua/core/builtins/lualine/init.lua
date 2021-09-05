local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {
    style = "lvim",
    options = {},
    sections = {},
    inactive_sections = {},
  },
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults)
  self.config:merge(overrides)

  if not self.config:get "config.options.theme" then
    -- TODO: remove use of global
    self.config:sub("config.options"):merge { theme = lvim.colorscheme }
  end
  local styles = require "core.builtins.lualine.styles"
  local style = styles.get(self.config:get "config.style")
  self.config:sub("config"):merge(style, { force = false })

  local utils = require "core.builtins.lualine.utils"
  if not utils.validate_theme(self.config:get "config.options.theme") then
    self.config:sub("config.options"):merge { theme = "auto" }
  end
end

function M:configure()
  local lualine = require "lualine"
  lualine.setup(self.config:get "config")

  if self.config:get "on_config_done" then
    self.config:get "on_config_done"(lualine)
  end
end

return M
