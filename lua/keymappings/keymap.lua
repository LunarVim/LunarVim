local M = {}

-- https://www.lua.org/pil/13.4.3.html
function setDefault(t, d)
  local mt = {
    __index = function()
      return d
    end,
  }
  setmetatable(t, mt)
end

M.default_opts = {
  n = { noremap = true, silent = true },
  i = { noremap = true, silent = true },
  v = { noremap = true, silent = true },
  x = { noremap = true, silent = true },
}
setDefault(M.default_opts, { silent = true })

-- possible keymaps:
-- 1. ['jk'] = '<ESC>'
-- 2. ['jk'] = {'<ESC>', { noremap = true, silent = true } }
function M.set_group(mode, keymaps)
  for key, val in pairs(keymaps) do
    local opt = M.default_opts[mode]
    if type(val) == "table" then
      opt = val[2]
      val = val[1]
    end
    vim.api.nvim_set_keymap(mode, key, val, opt)
  end
end

return M
