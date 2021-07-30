local M = {
  MODE = {
    INSERT = "i",
    NORMAL = "n",
    TERM = "t",
    VISUAL = "v",
    VISUAL_BLOCK = "x",
  },
}

-- Load key mappings for a given mode
-- @param mode One of the MODE enumeration values
-- @param keymaps The list of key mappings
-- @param opts The mapping options
M.load_mode = function(mode, keymaps, opts)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
-- @param opts The mapping options for each mode
M.load = function(keymaps, opts)
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping, opts[mode])
  end
end

return M
