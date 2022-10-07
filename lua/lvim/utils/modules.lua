local M = {}

local Log = require "lvim.core.log"
-- revisit this
-- function prequire(package)
--   local status, lib = pcall(require, package)
--   if status then
--     return lib
--   else
--     vim.notify("Failed to require '" .. package .. "' from " .. debug.getinfo(2).source)
--     return nil
--   end
-- end

local function _assign(old, new, k)
  local otype = type(old[k])
  local ntype = type(new[k])
  -- print("hi")
  if (otype == "thread" or otype == "userdata") or (ntype == "thread" or ntype == "userdata") then
    vim.notify(string.format("warning: old or new attr %s type be thread or userdata", k))
  end
  old[k] = new[k]
end

local function _replace(old, new, repeat_tbl)
  if repeat_tbl[old] then
    return
  end
  repeat_tbl[old] = true

  local dellist = {}
  for k, _ in pairs(old) do
    if not new[k] then
      table.insert(dellist, k)
    end
  end
  for _, v in ipairs(dellist) do
    old[v] = nil
  end

  for k, _ in pairs(new) do
    if not old[k] then
      old[k] = new[k]
    else
      if type(old[k]) ~= type(new[k]) then
        Log:debug(
          string.format("Reloader: mismatch between old [%s] and new [%s] type for [%s]", type(old[k]), type(new[k]), k)
        )
        _assign(old, new, k)
      else
        if type(old[k]) == "table" then
          _replace(old[k], new[k], repeat_tbl)
        else
          _assign(old, new, k)
        end
      end
    end
  end
end

M.require_clean = function(m)
  package.loaded[m] = nil
  _G[m] = nil
  local _, module = pcall(require, m)
  return module
end

M.require_safe = function(mod)
  local status_ok, module = pcall(require, mod)
  if not status_ok then
    local trace = debug.getinfo(2, "SL")
    local shorter_src = trace.short_src
    local lineinfo = shorter_src .. ":" .. (trace.currentline or trace.linedefined)
    local msg = string.format("%s : skipped loading [%s]", lineinfo, mod)
    Log:debug(msg)
  end
  return module
end

M.reload = function(mod)
  if not package.loaded[mod] then
    return M.require_safe(mod)
  end

  local old = package.loaded[mod]
  package.loaded[mod] = nil
  local new = M.require_safe(mod)

  if type(old) == "table" and type(new) == "table" then
    local repeat_tbl = {}
    _replace(old, new, repeat_tbl)
  end

  package.loaded[mod] = old
  return old
end

return M
