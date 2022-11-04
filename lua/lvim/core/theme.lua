local Log = require "lvim.core.log"

local M = {}

M.config = function()
  lvim.builtin.theme = {
    name = "lunar",
    lunar = {
      options = { -- currently unused
      },
    },
    tokyonight = {
      options = {
        on_highlights = function(hl, c)
          hl.IndentBlanklineContextChar = {
            fg = c.dark5,
          }
          hl.TSConstructor = {
            fg = c.blue1,
          }
          hl.TSTagDelimiter = {
            fg = c.dark5,
          }
        end,
        style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        transparent = lvim.transparent_window, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        sidebars = {
          "qf",
          "vista_kind",
          "terminal",
          "packer",
          "spectre_panel",
          "NeogitStatus",
          "help",
        },
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
        use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
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
  local status_ok, plugin = pcall(require, selected_theme)
  if not status_ok then
    return
  end
  pcall(function()
    plugin.setup(lvim.builtin.theme[selected_theme].options)
  end)

  -- ref: https://github.com/neovim/neovim/issues/18201#issuecomment-1104754564
  local colors = vim.api.nvim_get_runtime_file(("colors/%s.*"):format(lvim.colorscheme), false)
  if #colors == 0 then
    Log:debug(string.format("Could not find '%s' colorscheme", lvim.colorscheme))
    return
  end

  vim.g.colors_name = lvim.colorscheme
  vim.cmd("colorscheme " .. lvim.colorscheme)

  require("lvim.core.lualine").setup()
  require("lvim.core.lir").icon_setup()
end

return M
