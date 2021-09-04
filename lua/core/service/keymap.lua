local KeyMap = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  select_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  select_mode = "s",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function KeyMap.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2] or opt
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function KeyMap.load_mode(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    KeyMap.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function KeyMap.load(keymaps)
  for mode, mapping in pairs(keymaps) do
    KeyMap.load_mode(mode, mapping)
  end
end

function KeyMap.print(mode)
  print "List of LunarVim's default keymappings (not including which-key)"
  if mode then
    print(vim.inspect(lvim.keys[mode]))
  else
    print(vim.inspect(lvim.keys))
  end
end

function KeyMap.setup(leader_key, keys)
  vim.g.mapleader = leader_key == "space" and " " or leader_key
  KeyMap.load(keys)
end

return KeyMap
