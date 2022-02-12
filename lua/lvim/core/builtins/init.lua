local M = {}

local builtins = {
  "lvim.core.which-key",
  "lvim.core.gitsigns",
  "lvim.core.cmp",
  "lvim.core.dap",
  "lvim.core.terminal",
  "lvim.core.telescope",
  "lvim.core.treesitter",
  "lvim.core.nvimtree",
  "lvim.core.project",
  "lvim.core.bufferline",
  "lvim.core.autopairs",
  "lvim.core.comment",
  "lvim.core.notify",
  "lvim.core.lualine",
  "lvim.core.alpha",
}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = require(builtin_path)
    builtin.config(config)
  end
end

return M
