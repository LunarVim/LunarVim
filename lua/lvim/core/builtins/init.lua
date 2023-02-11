local M = {}

local builtins = {
  "lvim.core.builtins.which-key",
  "lvim.core.builtins.gitsigns",
  "lvim.core.builtins.cmp",
  "lvim.core.builtins.dap",
  "lvim.core.builtins.terminal",
  "lvim.core.builtins.telescope",
  "lvim.core.builtins.treesitter",
  "lvim.core.builtins.nvimtree",
  "lvim.core.builtins.lir",
  "lvim.core.builtins.illuminate",
  "lvim.core.builtins.indentlines",
  "lvim.core.builtins.breadcrumbs",
  "lvim.core.builtins.project",
  "lvim.core.builtins.bufferline",
  "lvim.core.builtins.autopairs",
  "lvim.core.builtins.comment",
  "lvim.core.builtins.lualine",
  "lvim.core.builtins.alpha",
  "lvim.core.builtins.mason",
}

---@class LvimBuiltin
---@field active boolean is builtin enabled
---@field on_config_done function function called after the builtin is set up

function M.init(config)
  ---@type {[string]: LvimBuiltin}
  lvim.builtin = {}

  for _, builtin_path in ipairs(builtins) do
    local builtin = reload(builtin_path)

    builtin.config(config)
  end
end

function M.setup(modname)
  local plugin = require("lvim.core.builtins." .. modname).setup()

  local builtin_tbl = lvim.builtin[modname:gsub("-", "_")]
  if plugin and type(builtin_tbl.on_config_done) == "function" then
    builtin_tbl.on_config_done(plugin)
  end
end

return M
