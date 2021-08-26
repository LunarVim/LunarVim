local M = {
  path = nil,
}

--- Create a new configuration.
-- @function Config
-- @param defaults The default config entries
setmetatable(M, {
  __call = function(cls, ...)
    return cls:new(...)
  end,
})

function M:new(defaults, opts)
  opts = opts or {}
  local config = {}

  config.entries = defaults
  config.path = opts.path

  M.__index = M
  setmetatable(config, M)

  return config
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = require "core.autocmds"

  config_path = config_path or self.path
  local config, err = loadfile(config_path)
  if err then
    print("Invalid configuration", config_path)
    print(err)
    return
  end

  self.path = config_path
  self:extend_with(config(), { force = false, log = true })
end

--- Get a sub configuration
-- @param path The path to the entry as a list of . separated keys
-- @param default The default value to use if not found
function M:get(path, default)
  local keys = vim.split(path, "%.")
  local entries = self.entries

  for _, key in ipairs(keys) do
    if not entries[key] then
      if type(default) == "table" then
        entries[key] = default
        return self:new(entries[key], { path = self.path })
      end
      return default
    end
    entries = entries[key]
  end

  if type(entries) ~= "table" then
    return entries
  end
  return self:new(entries, { path = self.path })
end

--- Merge recursively the given entries with our own.
-- @param entries The entries to merge
-- @param opts Optional paramters
-- @param opts.force Use the given value, default:true
-- @param opts.log TODO
function M:extend_with(entries, opts)
  opts = opts or {}
  local force = opts.behaviour or true
  -- local log = opts.log or true

  local function walk_entries(self_entries, p_entries, path)
    local function walk_entry(self_entry, entry, entry_path)
      if not self_entry then
        return entry
      end

      local entry_type = type(entry)
      local self_entry_type = type(self_entry)
      if entry_type ~= self_entry_type then
        print("Invalid type for", entry_path, "is", entry_type, "expected", self_entry_type)
        return force and entry or self_entry
      end
      if entry_type ~= "table" then
        return force and entry or self_entry
      end
      return walk_entries(self_entry, entry, entry_path)
    end

    local content = self_entries
    for key, value in pairs(p_entries) do
      content[key] = walk_entry(self_entries[key], value, path .. "." .. key)
    end

    return content
  end

  self.entries = walk_entries(self.entries, entries, "")

  return self
end

return M
