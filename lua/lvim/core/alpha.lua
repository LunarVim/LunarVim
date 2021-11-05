local M = {}

function M.config()
  local lvim_dashboard = require "lvim.core.alpha.dashboard"
  local lvim_startify = require "lvim.core.alpha.startify"
  lvim.builtin.alpha = {
    dashboard = lvim_dashboard.config(),
    startify = lvim_startify.config(),
    active = true,
    mode = "dashboard",
  }
end

function M.setup()
  local alpha = require "alpha"

  if lvim.builtin.alpha.mode == "dashboard" then
    local conf = lvim.builtin.alpha.dashboard
    local dashboard = require "alpha.themes.dashboard"

    dashboard.section.buttons.val = {}

    for _, entry in pairs(conf.buttons.entries) do
      local button = require("alpha.themes.dashboard").button
      table.insert(dashboard.section.buttons.val, button(entry.keybind, entry.description, entry.command))
    end

    dashboard.section.header.val = conf.header.val
    dashboard.section.header.opts.hl = conf.header.opts.hl
    dashboard.section.footer.val = conf.footer.val
    alpha.setup(dashboard.opts)
  else
    local conf = lvim.builtin.alpha.startify
    local startify = require "alpha.themes.startify"
    local button = require("alpha.themes.startify").button

    startify.section.top_buttons.val = {}
    startify.section.bottom_buttons.val = {}

    for _, entry in pairs(conf.top_buttons.entries) do
      table.insert(startify.section.top_buttons.val, button(entry.keybind, entry.description, entry.command))
    end
    for _, entry in pairs(conf.bottom_buttons.entries) do
      table.insert(startify.section.bottom_buttons.val, button(entry.keybind, entry.description, entry.command))
    end

    startify.section.header.val = conf.header.val
    startify.section.header.opts.hl = conf.header.opts.hl
    startify.section.footer.val = conf.footer.val
    alpha.setup(startify.opts)
  end
end

return M
