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
  self.config = Config(defaults):merge(overrides).entries

  if not self.config.config.options.theme then
    -- TODO: remove use of global
    self.config.config.options.theme = lvim.colorscheme
  end
  local styles = require "core.builtins.lualine.styles"
  local style = styles.get(self.config.config.style)
  self.config.config = vim.tbl_deep_extend("keep", self.config.config, style)
end

function M:configure()
  local lualine = require "lualine"

  local utils = require "core.builtins.lualine.utils"
  if not utils.validate_theme(self.config.config.options.theme) then
    self.config.config.options.theme = "auto"
  end

  lualine.setup(self.config.config)

  if self.config.on_config_done then
    self.config.on_config_done(lualine)
  end
end

return M
