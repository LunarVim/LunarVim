local M = {}
M.config = function()
  lvim.builtin.lualine.opts = {
    style = "lvim",
    options = {
      icons_enabled = nil,
      component_separators = nil,
      section_separators = nil,
      theme = nil,
      disabled_filetypes = {
        statusline = { "alpha" },
      },
      globalstatus = true,
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
  lvim.builtin.lualine = require("lvim.core.builtins").add_completion "lualine"
end

M.setup = function()
  if #vim.api.nvim_list_uis() == 0 then
    local Log = require "lvim.core.log"
    Log:debug "headless mode detected, skipping running setup for lualine"
    return
  end

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  require("lvim.core.lualine.styles").update()

  vim.opt.laststatus = 3
  lualine.setup(lvim.builtin.lualine.opts)
end

return M
