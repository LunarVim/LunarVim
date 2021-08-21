local M = {}

function M.validate_theme()
  local theme = lvim.builtin.lualine.options.theme

  local lualine_loader = require "lualine.utils.loader"
  local ok = pcall(lualine_loader.load_theme, theme)
  if not ok then
    lvim.builtin.lualine.options.theme = "auto"
  end
end

function M.env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

function M.get_mode_name()
  local names = {
    n = " NORMAL ",
    i = " INSERT ",
    c = " COMMAND ",
    v = " VISUAL ",
    V = " VISUAL LINE ",
    t = " TERMINAL ",
    R = " REPLACE ",
    [""] = " VISUAL BLOCK ",
  }

  local currentMode=names[vim.fn.mode()]
  if currentMode==nil then 
    return " "
  else 
    return currentMode 
  end
end

return M
