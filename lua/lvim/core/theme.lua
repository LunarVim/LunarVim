local Log = require "lvim.core.log"

local M = {}

M.config = function()
  lvim.builtin.theme = {
    name = "lunar",
    lunar = {
      options = { -- currently unused
      },
    },
  }
end

M.setup = function()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    Log:debug "headless mode detected, skipping running setup for lualine"
    return
  end

  local selected_theme = lvim.builtin.theme.name

  if vim.startswith(lvim.colorscheme, selected_theme) then
    local status_ok, plugin = pcall(require, selected_theme)
    if not status_ok then
      return
    end
    pcall(function()
      plugin.setup(lvim.builtin.theme[selected_theme].options)
    end)
  end

  -- ref: https://github.com/neovim/neovim/issues/18201#issuecomment-1104754564
  local colors = vim.api.nvim_get_runtime_file(("colors/%s.*"):format(lvim.colorscheme), false)
  if #colors == 0 then
    Log:debug(string.format("Could not find '%s' colorscheme", lvim.colorscheme))
    return
  end

  vim.g.colors_name = lvim.colorscheme
  vim.cmd("colorscheme " .. lvim.colorscheme)

  if package.loaded.lualine then
    require("lvim.core.lualine").setup()
  end
  if package.loaded.lir then
    require("lvim.core.lir").icon_setup()
  end
end

return M
