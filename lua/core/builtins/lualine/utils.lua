local M = {}

function M.validate_theme(theme)
  if type(theme) == "table" then
    return true
  end

  local lualine_loader = require "lualine.utils.loader"
  return pcall(lualine_loader.load_theme, theme)
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

return M
