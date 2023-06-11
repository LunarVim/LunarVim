local M = {}

local icons = lvim.icons.kind

local function select_menu_item()
  local menu = require("dropbar.api").get_current_dropbar_menu()
  if not menu then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(menu.win)
  local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
  if component then
    menu:click_on(component, nil, 1, "l")
  end
end

local function close_menu()
  local menu = require("dropbar.api").get_current_dropbar_menu()
  if not menu then
    return false
  end
  menu:close()
  return true
end

local function close_all_menus()
  while close_menu() do
  end
end

M.config = function()
  lvim.builtin.breadcrumbs = {
    active = true,
    on_config_done = nil,
    options = {
      icons = {
        kinds = {
          symbols = {
            Array = icons.Array .. " ",
            Boolean = icons.Boolean .. " ",
            Class = icons.Class .. " ",
            Color = icons.Color .. " ",
            Constant = icons.Constant .. " ",
            Constructor = icons.Constructor .. " ",
            Enum = icons.Enum .. " ",
            EnumMember = icons.EnumMember .. " ",
            Event = icons.Event .. " ",
            Field = icons.Field .. " ",
            File = icons.File .. " ",
            Folder = icons.Folder .. " ",
            Function = icons.Function .. " ",
            Interface = icons.Interface .. " ",
            Key = icons.Key .. " ",
            Keyword = icons.Keyword .. " ",
            Method = icons.Method .. " ",
            Module = icons.Module .. " ",
            Namespace = icons.Namespace .. " ",
            Null = icons.Null .. " ",
            Number = icons.Number .. " ",
            Object = icons.Object .. " ",
            Operator = icons.Operator .. " ",
            Package = icons.Package .. " ",
            Property = icons.Property .. " ",
            Reference = icons.Reference .. " ",
            Snippet = icons.Snippet .. " ",
            String = icons.String .. " ",
            Struct = icons.Struct .. " ",
            Text = icons.Text .. " ",
            TypeParameter = icons.TypeParameter .. " ",
            Unit = icons.Unit .. " ",
            Value = icons.Value .. " ",
            Variable = icons.Variable .. " ",
          },
        },
        ui = {
          bar = {
            separator = " " .. lvim.icons.ui.ChevronRight .. " ",
            extends = "…",
          },
          -- menu = {
          --   separator = " ",
          --   indicator = lvim.icons.ui.TriangleShortArrowRight,
          --   -- indicator = " ",
          -- },
        },
      },
      menu = {
        quick_navigation = true,
        keymaps = {
          ["l"] = select_menu_item,
          ["h"] = close_menu,
          ["<ESC>"] = close_all_menus,
          ["q"] = close_all_menus,
        },
        win_configs = {
          border = "rounded",
        },
      },
    },
  }
end

M.setup = function()
  local status_ok, dropbar = pcall(require, "dropbar")
  if not status_ok then
    return
  end
  dropbar.setup(lvim.builtin.breadcrumbs.options)

  if lvim.builtin.breadcrumbs.on_config_done then
    lvim.builtin.breadcrumbs.on_config_done()
  end
end

return M
