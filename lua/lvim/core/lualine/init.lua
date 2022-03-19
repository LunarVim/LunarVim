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
      globalstatus = false,
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
    on_config_done = nil,
  }
end

M.setup = function()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    local Log = require "lvim.core.log"
    Log:debug "headless mode detected, skipping running setup for lualine"
    return
  end

  require("lvim.core.lualine.styles").update()

  local lualine = require "lualine"
  lualine.setup(lvim.builtin.lualine)

  if lvim.builtin.lualine.on_config_done then
    lvim.builtin.lualine.on_config_done(lualine)
  end
end

return M
