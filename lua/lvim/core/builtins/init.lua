local M = {}

local builtins = {
  "which_key",
  "gitsigns",
  "cmp",
  "dap",
  "terminal",
  "telescope",
  "treesitter",
  "nvimtree",
  "lir",
  "illuminate",
  "indentlines",
  "breadcrumbs",
  "project",
  "bufferline",
  "autopairs",
  "comment",
  "lualine",
  "alpha",
  "mason",
}

function M.extend_defaults(config)
  ---@class LvimBuiltin
  ---@field active boolean is builtin enabled
  ---@field setup table options passed to setup()
  ---@field on_config function function called to configure the builtin
  ---@field on_config_done function function called to configure the builtin

  config.active = true
end

function M.init()
  for _, name in ipairs(builtins) do
    lvim.builtin[name] = {}
    M.extend_defaults(lvim.builtin[name])
  end

  reload("lvim.core.theme").config()

  lvim.builtin.cmp.cmdline = { enable = false }

  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }

  lvim.builtin.bigfile = {
    active = true,
    config = {},
  }
end

function M.setup(builtin_mod_name)
  local builtin_name = builtin_mod_name:gsub("-", "_")
  local mod = require("lvim.core." .. builtin_mod_name)

  -- initialize config table
  mod.config()
  local builtin = lvim.builtin[builtin_name]

  if type(builtin.on_config) == "function" then
    builtin.on_config()

    local deprecated = require "lvim.config._deprecated"
    local deprecation_handler = deprecated.post_builtin[builtin_name]
    if deprecation_handler then
      deprecation_handler()
    end
  end

  mod.setup()

  if type(builtin.on_config_done) == "function" then
    builtin.on_config_done()
  end
end

return M
