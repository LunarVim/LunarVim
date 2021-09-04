local M = {}

local builtins = {
  "core.builtins.which-key",
  "core.builtins.gitsigns",
  "core.builtins.cmp",
  "core.builtins.dashboard",
  "core.builtins.dap",
  "core.builtins.terminal",
  "core.builtins.telescope",
  "core.builtins.treesitter",
  "core.builtins.nvimtree",
  "core.builtins.project",
  "core.builtins.bufferline",
  "core.builtins.autopairs",
  "core.builtins.comment",
  "core.builtins.lspinstall",
  "core.builtins.lualine",
}

function M.setup(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = require(builtin_path)
    local config_path = builtin_path:gsub("core%.builtins%.", ""):gsub("-", "_")
    builtin:setup(config:sub(config_path))
  end
end

return M
