local M = {
  defaults = {
    active = true,
    on_config_done = nil,
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:config()
  local lspinstall = require "lspinstall"

  lspinstall.setup()
  if lvim.builtins.lspinstall.on_config_done then
    lvim.builtins.lspinstall.on_config_done(lspinstall)
  end
end

return M
