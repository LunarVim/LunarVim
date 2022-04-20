-- modified version from https://github.com/lewis6991/impatient.nvim

local vim = vim
local api = vim.api
local uv = vim.loop
local _loadfile = loadfile
local get_runtime = api.nvim__get_runtime
local fs_stat = uv.fs_stat
local mpack = vim.mpack

local appdir = os.getenv "APPDIR"

local M = {
  chunks = {
    cache = {},
    profile = nil,
    dirty = false,
    path = vim.fn.stdpath "cache" .. "/luacache_chunks",
  },
  modpaths = {
    cache = {},
    profile = nil,
    dirty = false,
    path = vim.fn.stdpath "cache" .. "/luacache_modpaths",
  },
  log = {},
}

_G.__luacache = M

if not get_runtime then
  -- nvim 0.5 compat
  get_runtime = function(paths, all, _)
    local r = {}
    for _, path in ipairs(paths) do
      local found = api.nvim_get_runtime_file(path, all)
      for i = 1, #found do
        r[#r + 1] = found[i]
      end
    end
    return r
  end
end

local function log(...)
  M.log[#M.log + 1] = table.concat({ string.format(...) }, " ")
end

function M.print_log()
  for _, l in ipairs(M.log) do
    print(l)
  end
end

function M.enable_profile()
  local P = require "lvim.impatient.profile"

  M.chunks.profile = {}
  M.modpaths.profile = {}

  P.setup(M.modpaths.profile)

  M.print_profile = function()
    P.print_profile(M)
  end

  vim.cmd [[command! LuaCacheProfile lua _G.__luacache.print_profile()]]
end

local function hash(modpath)
  local stat = fs_stat(modpath)
  if stat then
    return stat.mtime.sec .. stat.mtime.nsec .. stat.size
  end
  error("Could not hash " .. modpath)
end

local function modpath_mangle(modpath)
  if appdir then
    modpath = modpath:gsub(appdir, "/$APPDIR")
  end
  return modpath
end

local function modpath_unmangle(modpath)
  if appdir then
    modpath = modpath:gsub("/$APPDIR", appdir)
  end
  return modpath
end

local function profile(m, entry, name, loader)
  if m.profile then
    local mp = m.profile
    mp[entry] = mp[entry] or {}
    if not mp[entry].loader and loader then
      mp[entry].loader = loader
    end
    if not mp[entry][name] then
      mp[entry][name] = uv.hrtime()
    end
  end
end

local function mprofile(mod, name, loader)
  profile(M.modpaths, mod, name, loader)
end

local function cprofile(path, name, loader)
  profile(M.chunks, path, name, loader)
end

local function get_runtime_file(basename, paths)
  -- Look in the cache to see if we have already loaded a parent module.
  -- If we have then try looking in the parents directory first.
  local parents = vim.split(basename, "/")
  for i = #parents, 1, -1 do
    local parent = table.concat(vim.list_slice(parents, 1, i), "/")
    local ppath = M.modpaths.cache[parent]
    if ppath then
      if ppath:sub(-9) == "/init.lua" then
        ppath = ppath:sub(1, -10) -- a/b/init.lua -> a/b
      else
        ppath = ppath:sub(1, -5) -- a/b.lua -> a/b
      end

      for _, path in ipairs(paths) do
        -- path should be of form 'a/b/c.lua' or 'a/b/c/init.lua'
        local modpath = ppath .. "/" .. path:sub(#("lua/" .. parent) + 2)
        if fs_stat(modpath) then
          return modpath, "cache(p)"
        end
      end
    end
  end

  -- What Neovim does by default; slowest
  local modpath = get_runtime(paths, false, { is_lua = true })[1]
  return modpath, "standard"
end

local function get_runtime_file_cached(basename, paths)
  local mp = M.modpaths
  if mp.cache[basename] then
    local modpath = mp.cache[basename]
    if fs_stat(modpath) then
      mprofile(basename, "resolve_end", "cache")
      return modpath
    end
    mp.cache[basename] = nil
    mp.dirty = true
  end

  local modpath, loader = get_runtime_file(basename, paths)
  if modpath then
    mprofile(basename, "resolve_end", loader)
    log("Creating cache for module %s", basename)
    mp.cache[basename] = modpath_mangle(modpath)
    mp.dirty = true
  end
  return modpath
end

local function extract_basename(pats)
  local basename

  -- Deconstruct basename from pats
  for _, pat in ipairs(pats) do
    for i, npat in ipairs {
      -- Ordered by most specific
      "lua/(.*)/init%.lua",
      "lua/(.*)%.lua",
    } do
      local m = pat:match(npat)
      if i == 2 and m and m:sub(-4) == "init" then
        m = m:sub(0, -6)
      end
      if not basename then
        if m then
          basename = m
        end
      elseif m and m ~= basename then
        -- matches are inconsistent
        return
      end
    end
  end

  return basename
end

local function get_runtime_cached(pats, all, opts)
  local fallback = false
  if all or not opts or not opts.is_lua then
    -- Fallback
    fallback = true
  end

  local basename

  if not fallback then
    basename = extract_basename(pats)
  end

  if fallback or not basename then
    return get_runtime(pats, all, opts)
  end

  return { get_runtime_file_cached(basename, pats) }
end

-- Copied from neovim/src/nvim/lua/vim.lua with two lines changed
local function load_package(name)
  local basename = name:gsub("%.", "/")
  local paths = { "lua/" .. basename .. ".lua", "lua/" .. basename .. "/init.lua" }

  -- Original line:
  -- local found = vim.api.nvim__get_runtime(paths, false, {is_lua=true})
  local found = { get_runtime_file_cached(basename, paths) }
  if #found > 0 then
    local f, err = loadfile(found[1])
    return f or error(err)
  end

  local so_paths = {}
  for _, trail in ipairs(vim._so_trails) do
    local path = "lua" .. trail:gsub("?", basename) -- so_trails contains a leading slash
    table.insert(so_paths, path)
  end

  -- Original line:
  -- found = vim.api.nvim__get_runtime(so_paths, false, {is_lua=true})
  found = { get_runtime_file_cached(basename, so_paths) }
  if #found > 0 then
    -- Making function name in Lua 5.1 (see src/loadlib.c:mkfuncname) is
    -- a) strip prefix up to and including the first dash, if any
    -- b) replace all dots by underscores
    -- c) prepend "luaopen_"
    -- So "foo-bar.baz" should result in "luaopen_bar_baz"
    local dash = name:find("-", 1, true)
    local modname = dash and name:sub(dash + 1) or name
    local f, err = package.loadlib(found[1], "luaopen_" .. modname:gsub("%.", "_"))
    return f or error(err)
  end
  return nil
end

local function load_from_cache(path)
  local mc = M.chunks

  if not mc.cache[path] then
    return nil, string.format("No cache for path %s", path)
  end

  local mhash, codes = unpack(mc.cache[path])

  if mhash ~= hash(modpath_unmangle(path)) then
    mc.cache[path] = nil
    mc.dirty = true
    return nil, string.format("Stale cache for path %s", path)
  end

  local chunk = loadstring(codes)

  if not chunk then
    mc.cache[path] = nil
    mc.dirty = true
    return nil, string.format("Cache error for path %s", path)
  end

  return chunk
end

local function loadfile_cached(path)
  cprofile(path, "load_start")

  local chunk, err = load_from_cache(path)
  if chunk and not err then
    log("Loaded cache for path %s", path)
    cprofile(path, "load_end", "cache")
    return chunk
  end
  log(err)

  chunk, err = _loadfile(path)

  if not err then
    log("Creating cache for path %s", path)
    M.chunks.cache[modpath_mangle(path)] = { hash(path), string.dump(chunk) }
    M.chunks.dirty = true
  end

  cprofile(path, "load_end", "standard")
  return chunk, err
end

function M.save_cache()
  local function _save_cache(t)
    if t.dirty then
      log("Updating chunk cache file: %s", t.path)
      local f = io.open(t.path, "w+b")
      f:write(mpack.encode(t.cache))
      f:flush()
      t.dirty = false
    end
  end
  _save_cache(M.chunks)
  _save_cache(M.modpaths)
end

function M.clear_cache()
  local function _clear_cache(t)
    t.cache = {}
    os.remove(t.path)
  end
  _clear_cache(M.chunks)
  _clear_cache(M.modpaths)
end

local function init_cache()
  local function _init_cache(t)
    if fs_stat(t.path) then
      log("Loading cache file %s", t.path)
      local f = io.open(t.path, "rb")
      local ok
      ok, t.cache = pcall(function()
        return mpack.decode(f:read "*a")
      end)

      if not ok then
        log("Corrupted cache file, %s. Invalidating...", t.path)
        os.remove(t.path)
        t.cache = {}
      end
      t.dirty = not ok
    end
  end

  _init_cache(M.chunks)
  _init_cache(M.modpaths)
end

local function setup()
  init_cache()

  -- Override default functions
  vim._load_package = load_package
  vim.api.nvim__get_runtime = get_runtime_cached
  -- luacheck: ignore 121
  loadfile = loadfile_cached

  vim.cmd [[
    augroup impatient
      autocmd VimEnter,VimLeave * lua _G.__luacache.save_cache()
    augroup END

    command! LuaCacheClear lua _G.__luacache.clear_cache()
    command! LuaCacheLog   lua _G.__luacache.print_log()
  ]]
end

setup()

return M
