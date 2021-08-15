local M = {}
M.config = function()
  lvim.builtin.lualine = {
    active = true,
    style = "lvim",
    options = {
      icons_enabled = nil,
      component_separators = nil,
      section_separators = nil,
      theme = nil,
      disabled_filetypes = nil,
    },
    sections = {
      lualine_a = nil,
      lualine_b = nil,
      lualine_c = nil,
      lualine_x = nil,
      lualine_y = nil,
      lualine_z = nil,
    },
    inactive_sections = {
      lualine_a = nil,
      lualine_b = nil,
      lualine_c = nil,
      lualine_x = nil,
      lualine_y = nil,
      lualine_z = nil,
    },
    tabline = nil,
    extensions = nil,
  }
end

M.setup = function()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local styles = require "core.lualine.styles"
  lvim.builtin.lualine = styles.update(lvim.builtin.lualine, lvim.colorscheme)

  lualine.setup(lvim.builtin.lualine)

  if lvim.builtin.lualine.on_config_done then
    lvim.builtin.lualine.on_config_done(require "lualine")
  end
end

return M
