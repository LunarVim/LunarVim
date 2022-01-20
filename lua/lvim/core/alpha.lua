local M = {}

function M.config()
  local lvim_dashboard = require "lvim.core.alpha.dashboard"
  local lvim_startify = require "lvim.core.alpha.startify"
  lvim.builtin.alpha = {
    dashboard = { config = {}, section = lvim_dashboard.get_sections() },
    startify = { config = {}, section = lvim_startify.get_sections() },
    active = true,
    mode = "dashboard",
  }
end

local function resolve_buttons(theme_name, entries)
  local selected_theme = require("alpha.themes." .. theme_name)
  local val = {}
  for _, entry in pairs(entries) do
    table.insert(val, selected_theme.button(entry[1], entry[2], entry[3]))
  end
  return val
end

local function resolve_config(theme_name)
  local selected_theme = require("alpha.themes." .. theme_name)
  local resolved_section = selected_theme.section
  local section = lvim.builtin.alpha[theme_name].section

  for name, el in pairs(section) do
    for k, v in pairs(el) do
      if name:match "buttons" and k == "entries" then
        resolved_section[name].val = resolve_buttons(theme_name, v)
      elseif v then
        resolved_section[name][k] = v
      end
    end
  end

  return selected_theme.config
end

function M.setup()
  local alpha = require "alpha"
  local mode = lvim.builtin.alpha.mode
  local config = lvim.builtin.alpha[mode].config

  -- this makes it easier to use a completely custom configuration
  if vim.tbl_isempty(config) then
    config = resolve_config(mode)
  end

  alpha.setup(config)
end

return M
