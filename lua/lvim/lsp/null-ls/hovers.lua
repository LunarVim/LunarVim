local M = {}

local Log = require "lvim.core.log"

local null_ls = require "null-ls"
local services = require "lvim.lsp.null-ls.services"
local method = null_ls.methods.HOVER

function M.setup(formatter_configs)
  if vim.tbl_isempty(formatter_configs) then
    return
  end

  local registered = services.register_sources(formatter_configs, method)

  if #registered > 0 then
    Log:debug("Registered the following hovers: " .. unpack(registered))
  end
end

return M
