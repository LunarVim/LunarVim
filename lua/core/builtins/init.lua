local M = {}

local builtins = {
  "core.which-key",
  "core.gitsigns",
  "core.cmp",
  "core.dashboard",
  "core.dap",
  "core.terminal",
  "core.telescope",
  "core.treesitter",
  "core.nvimtree",
  "core.project",
  "core.bufferline",
  "core.autopairs",
  "core.comment",
  "core.lspinstall",
  "core.lualine",
}

function M.setup(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = require(builtin_path)
    local config_path = builtin_path:gsub("core", "builtins"):gsub("-", "_")
    builtin:setup(config:sub(config_path))
  end
end

return M
