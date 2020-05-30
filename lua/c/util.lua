--- Utility helpers
-- @module c.util

local util = {}

local autocmd = require("c.autocmd")

-- The startup window doesn't seem to pick up on vim.o changes >.<
function util.set_win_opt(name, value)
  vim.o[name] = value
  autocmd.bind_vim_enter(function()
    vim.wo[name] = value
  end)
end

-- The startup buffer doesn't seem to pick up on vim.o changes >.<
function util.set_buf_opt(name, value)
  vim.o[name] = value
  autocmd.bind_vim_enter(function()
    vim.bo[name] = value
  end)
end

return util