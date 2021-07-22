local M = {}

function M.init(colors)
  -- Set colorscheme
  vim.g.colors_name = colors.colorscheme

  -- Set custom highlights
  require("colors.highlight-replacer").apply(colors.highlights)
end

return M
