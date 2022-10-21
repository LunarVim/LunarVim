local M = {}

local builtins = {
  "lvim.core.theme",
  "lvim.core.which-key",
  "lvim.core.gitsigns",
  "lvim.core.cmp",
  "lvim.core.dap",
  "lvim.core.terminal",
  "lvim.core.telescope",
  "lvim.core.treesitter",
  "lvim.core.nvimtree",
  "lvim.core.lir",
  "lvim.core.illuminate",
  "lvim.core.indentlines",
  "lvim.core.breadcrumbs",
  "lvim.core.project",
  "lvim.core.bufferline",
  "lvim.core.autopairs",
  "lvim.core.comment",
  "lvim.core.lualine",
  "lvim.core.alpha",
  "lvim.core.mason",
}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = reload(builtin_path)

    builtin.config(config)
  end
end

return M
