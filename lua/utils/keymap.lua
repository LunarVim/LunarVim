local M = {}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
}

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
-- @param opts The mapping options
M.load_mode = function(mode, keymaps, opts)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for key, mapping in pairs(keymaps) do
    vim.api.nvim_set_keymap(mode, key, mapping[1], opts)
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
