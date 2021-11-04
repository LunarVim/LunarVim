local M = {}

function M.config()
  local startify = nil

  return startify
end

-- Send config to alpha
function M.setup(conf)
  local alpha = require "alpha"
  local startify = require "alpha.themes.startify"

  alpha.setup(conf or startify.opts)
end

return M
