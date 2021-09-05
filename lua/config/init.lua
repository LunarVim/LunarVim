local M = {}

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

  config.entries = vim.deepcopy(defaults)
  config.path = opts.path

  M.__index = M
  setmetatable(config, M)

  return config
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  config_path = config_path or self.path
  local config, err = loadfile(config_path)
  if err then
    print("Invalid configuration", config_path)
    print(err)
    return
  end

  self.path = config_path
  self:merge(config(), { force = true })
end

--- Get a sub configuration
-- @param path The path to the entry as a list of . separated keys
-- @return A configuration wrapping the entries designated by path
function M:sub(path)
  local keys = vim.split(path, "%.")
  local entries = self.entries

  for _, key in ipairs(keys) do
    if not entries[key] then
      entries[key] = {}
    end
    entries = entries[key]
  end

  return self:new(entries, { path = self.path })
end

--- Get a configuration entry
-- @param path The path to the entry as a list of . separated keys
-- @param default The default value to use if not found
function M:get(path, default)
  local keys = vim.split(path, "%.")
  local entries = self.entries

  for _, key in ipairs(keys) do
    if not entries[key] then
      return default
    end
    entries = entries[key]
  end

  return entries
end

--- Merge recursively the given entries with our own.
-- @param overrides The entries overrides to merge
-- @param opts Optional parameters
-- @param opts.force Use the given value, default: True
function M:merge(overrides, opts)
  opts = opts or {}
  local keep = not opts.force or false
  local Log = require "core.log"

  local function walk_entries(entries, _overrides, path)
    local function walk_entry(entry, override, entry_path)
      if not entry then
        return override
      end

      local entry_type = type(entry)
      local override_type = type(override)
      if entry_type ~= override_type then
        Log:error(
          string.format("Invalid config entry type '%s', expected '%s', is '%s'", entry_path, entry_type, override_type)
        )
        return entry
      end
      if override_type ~= "table" then
        if keep then
          return entry
        end
        return override
      end
      return walk_entries(entry, override, entry_path)
    end

    for key, value in pairs(_overrides) do
      entries[key] = walk_entry(entries[key], value, path .. "." .. key)
    end
    return entries
  end

  self.entries = walk_entries(self.entries, overrides, "")
  return self
end

return M
