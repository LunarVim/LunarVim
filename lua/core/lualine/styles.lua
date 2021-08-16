local M = {}
local conditions = require "core.lualine.conditions"
local colors = require "core.lualine.colors"

local none = {
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

local default = {
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

local lvim = {
  style = "lvim",
  options = {
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "dashboard", " ", "", "WhichKey" },
  },
  sections = {
    lualine_a = {
      {
        function()
          return " "
        end,
        left_padding = 0,
        right_padding = 0,
        condition = conditions.hide_in_width,
      },
    },
    lualine_b = {
      {
        "branch",
        icon = " ",
        condition = conditions.check_git_workspace,
      },
    },
    lualine_c = {
      {
        "diff",
        symbols = { added = "  ", modified = "柳", removed = " " },
        color_added = colors.green,
        color_modified = colors.yellow,
        color_removed = colors.red,
        condition = conditions.hide_in_width,
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        condition = conditions.hide_in_width,
        color = { bg = colors.bg },
      },
      {
        function()
          if next(vim.treesitter.highlighter.active) ~= nil then
            return "  "
          end
          return ""
        end,
        color = { fg = colors.green },
        condition = conditions.hide_in_width,
      },
      {
        function(msg)
          msg = msg or "LSP Inactive"
          local buf_clients = vim.lsp.buf_get_clients()
          if next(buf_clients) == nil then
            return msg
          end
          local buf_ft = vim.bo.filetype
          local buf_client_names = {}
          -- local null_ls_providers = require("lsp.null-ls").get_registered_providers_by_filetype(buf_ft)
          local null_ls_providers = require("lsp.utils").get_active_client_by_ft(buf_ft)
          for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
              table.insert(buf_client_names, client.name)
            end
          end
          vim.list_extend(buf_client_names, null_ls_providers)
          return table.concat(buf_client_names, ", ")
        end,
        condition = conditions.hide_in_width,
        icon = "",
        color = { gui = "bold" },
      },
      { "location", condition = conditions.hide_in_width },
      { "progress", condition = conditions.hide_in_width },
      {
        function()
          local label = "Spaces: "
          if not vim.api.nvim_buf_get_option(0, "expandtab") then
            label = "Tab size: "
          end
          return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = conditions.hide_in_width,
      },
      {
        "o:encoding",
        upper = true,
        condition = conditions.hide_in_width,
      },
    },
    lualine_y = { "filetype" },
    lualine_z = {},
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

local styles = {
  lvim = lvim,
  default = default,
  none = none,
}

function M.update(config, colorscheme)
  local style = config.style

  if style ~= "none" and style ~= "default" and style ~= "lvim" then
    print 'Valid lualine style options are: "lvim" or "default" or "none"'
    print '"lvim" style is applied.'
    style = "lvim"
  end

  local selected_style = vim.deepcopy(styles[style])

  return {
    active = true,
    style = style,
    options = {
      icons_enabled = config.options.icons_enabled or selected_style.options.icons_enabled,
      component_separators = config.options.component_separators or selected_style.options.component_separators,
      section_separators = config.options.section_separators or selected_style.options.section_separators,
      theme = config.options.theme or colorscheme or "auto",
      disabled_filetypes = config.options.disabled_filetypes or selected_style.options.disabled_filetypes,
    },
    sections = {
      lualine_a = config.sections.lualine_a or selected_style.sections.lualine_a,
      lualine_b = config.sections.lualine_b or selected_style.sections.lualine_b,
      lualine_c = config.sections.lualine_c or selected_style.sections.lualine_c,
      lualine_x = config.sections.lualine_x or selected_style.sections.lualine_x,
      lualine_y = config.sections.lualine_y or selected_style.sections.lualine_y,
      lualine_z = config.sections.lualine_z or selected_style.sections.lualine_z,
    },
    inactive_sections = {
      lualine_a = config.inactive_sections.lualine_a or selected_style.inactive_sections.lualine_a,
      lualine_b = config.inactive_sections.lualine_b or selected_style.inactive_sections.lualine_b,
      lualine_c = config.inactive_sections.lualine_c or selected_style.inactive_sections.lualine_c,
      lualine_x = config.inactive_sections.lualine_x or selected_style.inactive_sections.lualine_x,
      lualine_y = config.inactive_sections.lualine_y or selected_style.inactive_sections.lualine_y,
      lualine_z = config.inactive_sections.lualine_z or selected_style.inactive_sections.lualine_z,
    },
    tabline = config.tabline or selected_style.tabline,
    extensions = config.extensions or selected_style.extensions,
  }
end

return M
