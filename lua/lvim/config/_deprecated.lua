---@diagnostic disable: deprecated
local M = {}

local function deprecate(name, alternative)
  local in_headless = #vim.api.nvim_list_uis() == 0
  if in_headless then
    return
  end

  alternative = alternative or "See https://github.com/LunarVim/LunarVim#breaking-changes"

  local trace = debug.getinfo(3, "Sl")
  local shorter_src = trace.short_src
  local t = shorter_src .. ":" .. (trace.currentline or trace.lastlinedefined)
  vim.schedule(function()
    vim.notify_once(string.format("%s: `%s` is deprecated.\n %s.", t, name, alternative), vim.log.levels.WARN)
  end)
end

function M.pre_user_config()
  local mt = {
    __newindex = function(_, k, _)
      deprecate(k)
    end,
  }

  ---@deprecated
  lvim.builtin.theme.options = {}
  setmetatable(lvim.builtin.theme.options, {
    __newindex = function(_, k, v)
      deprecate("lvim.builtin.theme.options." .. k, "Use `lvim.builtin.theme.<theme>.options` instead")
      lvim.builtin.theme.tokyonight.options[k] = v
    end,
  })

  for _, builtin in ipairs {
    "indentlines",
    "illuminate",
    "breadcrumbs",
  } do
    lvim.builtin[builtin].options = {}
  end
  lvim.builtin.gitsigns.options = {}
end

function M.post_user_config()
  if lvim.autocommands.custom_groups then
    deprecate(
      "lvim.autocommands.custom_groups",
      "Use vim.api.nvim_create_autocmd instead or check LunarVim#2592 to learn about the new syntax"
    )
  end

  local function convert_spec_to_lazy(spec)
    local alternatives = {
      setup = "init",
      as = "name",
      opt = "lazy",
      run = "build",
      lock = "pin",
      tag = "version",
    }

    alternatives.requires = function()
      if type(spec.requires) == "string" then
        spec.dependencies = { spec.requires }
      else
        spec.dependencies = spec.requires
      end

      return "Use `dependencies` instead"
    end

    alternatives.disable = function()
      if type(spec.disabled) == "function" then
        spec.enabled = function()
          return not spec.disabled()
        end
      else
        spec.enabled = not spec.disabled
      end
      return "Use `enabled` instead"
    end

    alternatives.wants = function()
      return "It's not needed in most cases, otherwise use `dependencies`."
    end
    alternatives.needs = alternatives.wants

    alternatives.module = function()
      spec.lazy = true
      return "Use `lazy = true` instead."
    end

    for old_key, alternative in pairs(alternatives) do
      if spec[old_key] ~= nil then
        local message

        if type(alternative) == "function" then
          message = alternative()
        else
          spec[alternative] = spec[old_key]
        end
        spec[old_key] = nil

        message = message or string.format("Use `%s` instead.", alternative)
        deprecate(
          string.format("%s` in `lvim.plugins", old_key),
          message .. " See https://github.com/folke/lazy.nvim#-migration-guide"
        )
      end
    end

    if spec[1] and spec[1]:match "^http" then
      spec.url = spec[1]
      spec[1] = nil
      deprecate("{ 'http...' }` in `lvim.plugins", "Use { url = 'http...' } instead.")
    end
  end

  for _, plugin in ipairs(lvim.plugins) do
    if type(plugin) == "table" then
      convert_spec_to_lazy(plugin)
    end
  end
end

M.post_builtin = {}

local function builtin_added_opts(builtin)
  local table = lvim.builtin[builtin]
  local allowed_keys = { active = true, on_config = true, on_config_done = true, opts = true }
  local old_opts = { "options", "setup" }
  for key, value in pairs(table) do
    if not allowed_keys[key] then
      local message
      if vim.tbl_contains(old_opts, key) then
        table.opts = value

        message =
          string.format("`lvim.builtin.%s.%s` is deprecated, use `lvim.builtin.%s.opts` instead", builtin, key, builtin)
      else
        table.opts[key] = value

        message = string.format(
          "`lvim.builtin.%s.%s` is deprecated, use `lvim.builtin.%s.opts.%s` instead",
          builtin,
          key,
          builtin,
          key
        )
      end
      vim.schedule(function()
        vim.notify(message, vim.log.levels.WARN)
      end)
    end
  end
end

for _, builtin in ipairs {
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
} do
  M.post_builtin[builtin] = function()
    builtin_added_opts(builtin)
  end
end

return M
