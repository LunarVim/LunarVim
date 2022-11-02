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

function M.handle()
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

  ---@deprecated
  lvim.builtin.notify = {}
  setmetatable(lvim.builtin.notify, {
    __newindex = function(_, k, _)
      deprecate("lvim.builtin.notify." .. k, "See LunarVim#3294")
    end,
  })

  if lvim.lsp.override and not vim.tbl_isempty(lvim.lsp.override) then
    deprecate("lvim.lsp.override", "Use `lvim.lsp.automatic_configuration.skipped_servers` instead")
    vim.tbl_map(function(c)
      if not vim.tbl_contains(lvim.lsp.automatic_configuration.skipped_servers, c) then
        table.insert(lvim.lsp.automatic_configuration.skipped_servers, c)
      end
    end, lvim.lsp.override)
  end

  if lvim.autocommands.custom_groups then
    deprecate(
      "lvim.autocommands.custom_groups",
      "Use vim.api.nvim_create_autocmd instead or check LunarVim#2592 to learn about the new syntax"
    )
  end

  if lvim.lsp.automatic_servers_installation then
    deprecate(
      "lvim.lsp.automatic_servers_installation",
      "Use `lvim.lsp.installer.setup.automatic_installation` instead"
    )
  end

  ---@deprecated
  lvim.builtin.dashboard = {}
  setmetatable(lvim.builtin.dashboard, {
    __newindex = function(_, k, _)
      deprecate("lvim.builtin.dashboard." .. k, "Use `lvim.builtin.alpha` instead. See LunarVim#1906")
    end,
  })

  ---@deprecated
  lvim.lsp.popup_border = {}
  setmetatable(lvim.lsp.popup_border, mt)

  ---@deprecated
  lvim.lang = {}
  setmetatable(lvim.lang, mt)
end

return M
