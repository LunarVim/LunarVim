local M = {}

local builtins = {
  "lvim.builtin.which-key",
  "lvim.builtin.gitsigns",
  "lvim.builtin.cmp",
  "lvim.builtin.dap",
  "lvim.builtin.terminal",
  "lvim.builtin.telescope",
  "lvim.builtin.treesitter",
  "lvim.builtin.nvimtree",
  "lvim.builtin.lir",
  "lvim.builtin.illuminate",
  "lvim.builtin.indentlines",
  "lvim.builtin.breadcrumbs",
  "lvim.builtin.project",
  "lvim.builtin.bufferline",
  "lvim.builtin.autopairs",
  "lvim.builtin.comment",
  "lvim.builtin.lualine",
  "lvim.builtin.alpha",
  "lvim.builtin.mason",
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
  local plugin = require("lvim.builtin." .. modname).setup()

  local builtin_tbl = lvim.builtin[modname:gsub("-", "_")]
  if plugin and type(builtin_tbl.on_config_done) == "function" then
    builtin_tbl.on_config_done(plugin)
  end
end

return M
