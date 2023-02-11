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
  local plugin = require("lvim.core." .. modname).setup()

  local builtin_tbl = lvim.builtin[modname:gsub("-", "_")]
  if type(builtin_tbl.on_config_done) == "function" then
    builtin_tbl.on_config_done(plugin)
  end
end

return M
