--- Plugin management with vim-plug
-- @module u.plug

local plug = {}

local PLUGIN_DIR = "~/.config/nvim/autoload/plugged"

--- Update vim-plug
function plug.update_manager()
  vim.api.nvim_command("PlugUpgrade")
end

--- Update all plugins and install new ones
function plug.update_plugins()
  vim.api.nvim_command("PlugUpdate")
end

--- Update vim-plug, update all plugins, and install new ones
function plug.update_all()
  plug.update_manager()
  plug.update_plugins()
end

--- Start loading all registered plugins
function plug.finish_plugin_registration()
  vim.fn["plug#begin"](PLUGIN_DIR)

  for _, v in pairs(plug.plugins) do
    if type(v) == "string" then
      vim.fn["plug#"](v)
    elseif type(v) == "table" then
      local plugin = vim.deepcopy(v)
      local pkg = plugin[1]
      assert(pkg ~= nil, "Must specify package as first index")
      plugin[1] = nil
      vim.fn["plug#"](pkg, plugin)
    end
  end

  vim.fn["plug#end"]()

  plug.finished_plugin_init = true
end

plug.finished_plugin_init = false
plug.plugins = {}

--- Register a plugin
--
-- @tparam string plugin See vim-plug docs (Eg: `"preservim/nerdtree"`)
-- @tparam[opt] table options See vim-plug docs (Eg: `{ on = { "Cdo", "Ldo" } }`)
function plug.add_plugin(plugin, options)
  assert(not plug.finished_plugin_init, "Tried to add a plugin after plugin registration was over")
  if options == nil then
    table.insert(plug.plugins, plugin)
  else
    options[1] = plugin
    table.insert(plug.plugins, options)
  end
end

--- Check if a plugin has been registered
--
-- @tparam string plugin The name of the plugin Eg: `vim-airline`
function plug.has_plugin(plugin)
  plugin = "/" .. plugin

  for _, v in pairs(plug.plugins) do
    if type(v) == "string" then
      if vim.endswith(v, plugin) then return true end
      if vim.endswith(v, plugin .. ".git") then return true end
    elseif type(v) == "table" then
      if vim.endswith(v[1], plugin) then return true end
      if vim.endswith(v[1], plugin .. ".git") then return true end
    end
  end

  return false
end

return plug
