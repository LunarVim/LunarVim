local plugin_loader = {}

function plugin_loader:init()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = "~/.local/share/lunarvim/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
  end

  local packer_ok, packer = pcall(require, "packer")
  if not packer_ok then
    return
  end

  local util = require "packer.util"

  packer.init {
    package_root = util.join_paths "~/.local/share/lunarvim/site/pack/",
    compile_path = util.join_paths("~/.config/lvim", "plugin", "packer_compiled.lua"),
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return util.float { border = "single" }
      end,
    },
  }

  self.packer = packer
  return self
end

local builtin_mapper = {
  config = function(builtin)
    local config = lvim.builtin[builtin.name]

    if config == nil or config.on_config_done == nil then
      return builtin.setup
    end
    -- NOTE: closure variables can't be captured yet
    -- https://github.com/wbthomason/packer.nvim/discussions/513
    return function()
      local module = builtin.setup()
      config.on_config_done(module)
    end
  end,
  disable = function(builtin)
    local config = lvim.builtin[builtin.name]
    if config == nil or config.active == nil then
      return false
    end
    return not config.active
  end,
}

function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        print(plugin[1])
        local builtin = plugin["_builtin"]
        if builtin then
          plugin["_builtin"] = nil
          for attr, mapper in pairs(builtin_mapper) do
            local mapped = mapper(builtin)
            plugin[attr] = mapped
          end
        end

        use(plugin)
      end
    end
  end)
end

return {
  init = function()
    return plugin_loader:init()
  end,
}
