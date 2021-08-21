local M = {}
local components = require "core.lualine.components"

local styles = {
  lvim = nil,
  default = nil,
  none = nil,
}

styles.none = {
  style = "none",
  options = {
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

styles.default = {
  style = "default",
  options = {
    icons_enabled = true,
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

styles.lvim = {
  style = "lvim",
  options = {
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "dashboard" },
  },
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.diagnostics,
      components.treesitter,
      components.lsp,
      -- components.location,
      -- components.progress,
      -- components.spaces,
      -- components.encoding,
      components.filetype,
    },
    lualine_y = {
      -- components.filetype,
    },
    lualine_z = {
      components.scrollbar,
    },
  },
  inactive_sections = {
    lualine_a = {
      "filename",
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "nvim-tree" },
}

function M.get_style(style)
  local style_keys = vim.tbl_keys(styles)
  if not vim.tbl_contains(style_keys, style) then
    local Log = require "core.log"
    local logger = Log:get_default()
    logger.error(
      "Invalid lualine style",
      string.format('"%s"', style),
      "options are: ",
      string.format('"%s"', table.concat(style_keys, '", "'))
    )
    logger.info '"lvim" style is applied.'
    style = "lvim"
  end

  return vim.deepcopy(styles[style])
end

function M.update()
  local config = lvim.builtin.lualine
  local style = M.get_style(config.style)

  lvim.builtin.lualine = {
    active = true,
    style = style.style,
    options = {
      icons_enabled = config.options.icons_enabled or style.options.icons_enabled,
      component_separators = config.options.component_separators or style.options.component_separators,
      section_separators = config.options.section_separators or style.options.section_separators,
      theme = config.options.theme or lvim.colorscheme or "auto",
      disabled_filetypes = config.options.disabled_filetypes or style.options.disabled_filetypes,
    },
    sections = {
      lualine_a = config.sections.lualine_a or style.sections.lualine_a,
      lualine_b = config.sections.lualine_b or style.sections.lualine_b,
      lualine_c = config.sections.lualine_c or style.sections.lualine_c,
      lualine_x = config.sections.lualine_x or style.sections.lualine_x,
      lualine_y = config.sections.lualine_y or style.sections.lualine_y,
      lualine_z = config.sections.lualine_z or style.sections.lualine_z,
    },
    inactive_sections = {
      lualine_a = config.inactive_sections.lualine_a or style.inactive_sections.lualine_a,
      lualine_b = config.inactive_sections.lualine_b or style.inactive_sections.lualine_b,
      lualine_c = config.inactive_sections.lualine_c or style.inactive_sections.lualine_c,
      lualine_x = config.inactive_sections.lualine_x or style.inactive_sections.lualine_x,
      lualine_y = config.inactive_sections.lualine_y or style.inactive_sections.lualine_y,
      lualine_z = config.inactive_sections.lualine_z or style.inactive_sections.lualine_z,
    },
    tabline = config.tabline or style.tabline,
    extensions = config.extensions or style.extensions,
    on_config_done = config.on_config_done,
  }
end

return M
