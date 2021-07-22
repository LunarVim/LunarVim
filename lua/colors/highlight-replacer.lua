local M = {}

local function highlight_cmd(group, properties)
  local bg = properties.bg == nil and "" or "guibg=" .. properties.bg
  local fg = properties.fg == nil and "" or "guifg=" .. properties.fg
  local style = properties.style == nil and "" or "gui=" .. properties.style

  local cmd = table.concat({
    "highlight",
    group,
    bg,
    fg,
    style,
  }, " ")

  return cmd
end

function M.apply(skeleton)
  local highlights = {}

  for group, properties in pairs(skeleton) do
    local cmd = highlight_cmd(group, properties)
    table.insert(highlights, { "ColorScheme", "*", cmd })
  end

  require("lv-utils").define_augroups { highlights = highlights }
end

return M
