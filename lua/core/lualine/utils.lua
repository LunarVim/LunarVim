local M = {}

function M.validate_theme()
  local theme = lvim.builtin.lualine.options.theme

  local lualine_loader = require "lualine.utils.loader"
  local ok, validated_theme = pcall(lualine_loader.load_theme, theme)
  if not ok and type(validated_theme) ~= "table" then
    lvim.builtin.lualine.options.theme = "auto"
  end
end

return M
