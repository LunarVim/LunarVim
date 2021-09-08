local plugin_loader = {}

function plugin_loader.bootstrap()
  local install_path = "~/.local/share/lunarvim/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  end

  vim.cmd "packadd packer.nvim"
end

function plugin_loader:setup()
  plugin_loader:bootstrap()

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
        return util.float { border = "rounded" }
      end,
    },
  }

  self.packer = packer
  return self
end

function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        if plugin.config and type(plugin.config) == "string" and string.find(plugin.config, "core.") then
          plugin.config = 'require("' .. plugin.config .. '").setup()'
        end

        use(plugin)
      end
    end
  end)
end

return plugin_loader
