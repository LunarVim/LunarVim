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

---@class LvimBuiltin
---@field active boolean is builtin enabled
---@field opts table options passed to setup()
---@field on_config function function called to configure the builtin
---@field on_config_done function function called to configure the builtin

function M.add_completion(builtin)
  local table

  if type(builtin) == "string" then
    table = lvim.builtin[builtin]
  else
    table = builtin
  end

  ---@cast table +LvimBuiltin
  return table
end

function M.init()
  for _, name in ipairs(builtins) do
    lvim.builtin[name] = { active = true }
  end

  reload("lvim.core.theme").config()

  lvim.builtin.cmp.opts = { cmdline = { enable = false } }

  lvim.builtin.luasnip = {
    opts = {
      sources = {
        friendly_snippets = true,
      },
    },
  }

  lvim.builtin.bigfile = {
    active = true,
    opts = {
      configure_treesitter = false,
    },
  }

  lvim.lsp = {}
end

-- Configure and set up a builtin
function M.setup(name, mod_path, config_table)
  local mod = require(mod_path or ("lvim.core." .. name:gsub("_", "-")))

  mod.config()
  local builtin = config_table or lvim.builtin[name]

  if type(builtin.on_config) == "function" then
    builtin.on_config()

    local deprecated = require "lvim.config._deprecated"
    local deprecation_handler = deprecated.post_builtin[name]
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
