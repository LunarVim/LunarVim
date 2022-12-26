local M = {}
M.config = function()
  lvim.builtin.undotree = {
    active = true,
    options = {
      WindowLayout = 2,
      ShortIndicators = 1,
      SplitWidth = 24,
      DiffpanelHeight = 10,
      DiffAutoOpen = 1,
      SetFocusWhenToggle = 1,
      TreeNodeShape = '*',
      TreeVertShape = '|',
      TreeSplitShape = '/',
      TreeReturnShape = '\\',
      DiffCommand = "diff",
      RelativeTimestamp = 1,
      HighlightChangedText = 1,
      HighlightChangedWithSign = 1,
      HighlightSyntaxAdd = "DiffAdd",
      HighlightSyntaxChange = "DiffChange",
      HighlightSyntaxDel = "DiffDelete",
      HelpLine = 1,
      CursorLine = 1
    }
  }
end

M.setup = function()
  for key, value in pairs(lvim.builtin.undotree.options) do
    if (not vim.g["undotree_" .. key]) then
      vim.g["undotree_" .. key] = value
    end
  end
end

return M
