local M = {}

local builtins_path = {
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

local function list()
  local builtins = {}

  for _, builtin_path in ipairs(builtins_path) do
    local name = builtin_path:gsub("core%.builtins%.", ""):gsub("-", "_")
    builtins[name] = require(builtin_path)
  end

  return builtins
end

function M:setup(config, loader)
  self.loader = loader
  for _, builtin_path in ipairs(builtins_path) do
    local builtin = require(builtin_path)
    local config_path = builtin_path:gsub("core%.builtins%.", ""):gsub("-", "_")
    builtin:setup(config:get(config_path, {}))
  end
end

function M:load(user_plugins)
  local builtins_config = require "core.builtins.config"
  local builtins = list()
  self.loader:load { builtins_config.load(builtins), user_plugins }
end

return M
