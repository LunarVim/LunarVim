-- modified version from https://github.com/lewis6991/impatient.nvim
local vim = vim
local api = vim.api
local uv = vim.loop
local _loadfile = loadfile
local get_runtime = api.nvim__get_runtime
local fs_stat = uv.fs_stat
local mpack = vim.mpack
local loadlib = package.loadlib

local std_cache = vim.fn.stdpath "cache"

local sep
if jit.os == "Windows" then
  sep = "\\"
else
  sep = "/"
end

local std_dirs = {
  ["<APPDIR>"] = os.getenv "APPDIR",
  ["<VIMRUNTIME>"] = os.getenv "VIMRUNTIME",
  ["<STD_DATA>"] = vim.fn.stdpath "data",
  ["<STD_CONFIG>"] = vim.fn.stdpath "config",
  ["<LVIM_BASE>"] = get_lvim_base_dir(),
  ["<LVIM_RUNTIME>"] = get_runtime_dir(),
  ["<LVIM_CONFIG>"] = get_config_dir(),
}

local function modpath_mangle(modpath)
  for name, dir in pairs(std_dirs) do
    modpath = modpath:gsub(dir, name)
  end
  return modpath
end

local function modpath_unmangle(modpath)
  for name, dir in pairs(std_dirs) do
    modpath = modpath:gsub(name, dir)
  end
  return modpath
end

-- Overridable by user
local default_config = {
  chunks = {
    enable = true,
    path = std_cache .. sep .. "luacache_chunks",
  },
  modpaths = {
    enable = true,
    path = std_cache .. sep .. "luacache_modpaths",
  },
}

-- State used internally
local default_state = {
  chunks = {
    cache = {},
    profile = nil,
    dirty = false,
    get = function(self, path)
      return self.cache[modpath_mangle(path)]
    end,
    set = function(self, path, chunk)
      self.cache[modpath_mangle(path)] = chunk
    end,
  },
  modpaths = {
    cache = {},
    profile = nil,
    dirty = false,
    get = function(self, mod)
      if self.cache[mod] then
        return modpath_unmangle(self.cache[mod])
      end
    end,
    set = function(self, mod, path)
      self.cache[mod] = modpath_mangle(path)
    end,
  },
  log = {},
}

---@diagnostic disable-next-line: undefined-field
local M = vim.tbl_deep_extend("keep", _G.__luacache_config or {}, default_config, default_state)
_G.__luacache = M

local function log(...)
  M.log[#M.log + 1] = table.concat({ string.format(...) }, " ")
end

local function print_log()
  for _, l in ipairs(M.log) do
    print(l)
  end
end

local function hash(modpath)
  local stat = fs_stat(modpath)
  if stat then
    return stat.mtime.sec .. stat.mtime.nsec .. stat.size
  end
  error("Could not hash " .. modpath)
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
  if M.chunks.profile then
    path = modpath_mangle(path)
  end
  profile(M.chunks, path, name, loader)
end

function M.enable_profile()
  local P = require "lvim.impatient.profile"

  M.chunks.profile = {}
  M.modpaths.profile = {}

  loadlib = function(path, fun)
    cprofile(path, "load_start")
    local f, err = package.loadlib(path, fun)
    cprofile(path, "load_end", "standard")
    return f, err
  end

  P.setup(M.modpaths.profile)

  api.nvim_create_user_command("LuaCacheProfile", function()
    P.print_profile(M, std_dirs)
  end, {})
end

local function get_runtime_file_from_parent(basename, paths)
  -- Look in the cache to see if we have already loaded a parent module.
  -- If we have then try looking in the parents directory first.
  local parents = vim.split(basename, sep)
  for i = #parents, 1, -1 do
    local parent = table.concat(vim.list_slice(parents, 1, i), sep)
    local ppath = M.modpaths:get(parent)
    if ppath then
      if ppath:sub(-9) == (sep .. "init.lua") then
        ppath = ppath:sub(1, -10) -- a/b/init.lua -> a/b
      else
        ppath = ppath:sub(1, -5) -- a/b.lua -> a/b
      end

      for _, path in ipairs(paths) do
        -- path should be of form 'a/b/c.lua' or 'a/b/c/init.lua'
        local modpath = ppath .. sep .. path:sub(#("lua" .. sep .. parent) + 2)
        if fs_stat(modpath) then
          return modpath, "cache(p)"
        end
      end
    end
  end
end

local rtp = vim.split(vim.o.rtp, ",")

-- Make sure modpath is in rtp and that modpath is in paths.
local function validate_modpath(modpath, paths)
  local match = false
  for _, p in ipairs(paths) do
    if vim.endswith(modpath, p) then
      match = true
      break
    end
  end
  if not match then
    return false
  end
  for _, dir in ipairs(rtp) do
    if vim.startswith(modpath, dir) then
      return fs_stat(modpath) ~= nil
    end
  end
  return false
end

local function get_runtime_file_cached(basename, paths)
  local modpath, loader
  local mp = M.modpaths
  if mp.enable then
    local modpath_cached = mp:get(basename)
    if modpath_cached then
      modpath, loader = modpath_cached, "cache"
    else
      modpath, loader = get_runtime_file_from_parent(basename, paths)
    end

    if modpath and not validate_modpath(modpath, paths) then
      modpath = nil

      -- Invalidate
      mp.cache[basename] = nil
      mp.dirty = true
    end
  end

  if not modpath then
    -- What Neovim does by default; slowest
    modpath, loader = get_runtime(paths, false, { is_lua = true })[1], "standard"
  end

  if modpath then
    mprofile(basename, "resolve_end", loader)
    if mp.enable and loader ~= "cache" then
      log("Creating cache for module %s", basename)
      mp:set(basename, modpath)
      mp.dirty = true
    end
  end

  return modpath
end

local function extract_basename(pats)
  local basename

  -- Deconstruct basename from pats
  for _, pat in ipairs(pats) do
    for i, npat in ipairs {
      -- Ordered by most specific
      "lua"
        .. sep
        .. "(.*)"
        .. sep
        .. "init%.lua",
      "lua" .. sep .. "(.*)%.lua",
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
  local basename = name:gsub("%.", sep)
  local paths = { "lua" .. sep .. basename .. ".lua", "lua" .. sep .. basename .. sep .. "init.lua" }

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
    local f, err = loadlib(found[1], "luaopen_" .. modname:gsub("%.", "_"))
    return f or error(err)
  end
  return nil
end

local function load_from_cache(path)
  local mc = M.chunks

  local cache = mc:get(path)

  if not cache then
    return nil, string.format("No cache for path %s", path)
  end

  local mhash, codes = unpack(cache)

  if mhash ~= hash(path) then
    mc:set(path)
    mc.dirty = true
    return nil, string.format("Stale cache for path %s", path)
  end

  local chunk = loadstring(codes)

  if not chunk then
    mc:set(path)
    mc.dirty = true
    return nil, string.format("Cache error for path %s", path)
  end

  return chunk
end

local function loadfile_cached(path)
  cprofile(path, "load_start")

  local chunk, err

  if M.chunks.enable then
    chunk, err = load_from_cache(path)
    if chunk and not err then
      log("Loaded cache for path %s", path)
      cprofile(path, "load_end", "cache")
      return chunk
    end
    log(err)
  end

  chunk, err = _loadfile(path)

  if not err and M.chunks.enable then
    log("Creating cache for path %s", path)
    M.chunks:set(path, { hash(path), string.dump(chunk) })
    M.chunks.dirty = true
  end

  cprofile(path, "load_end", "standard")
  return chunk, err
end

function M.save_cache()
  local function _save_cache(t)
    if not t.enable then
      return
    end
    if t.dirty then
      log("Updating chunk cache file: %s", t.path)
      local f = assert(io.open(t.path, "w+b"))
      f:write(mpack.encode(t.cache))
      f:flush()
      t.dirty = false
    end
  end
  _save_cache(M.chunks)
  _save_cache(M.modpaths)
end

local function clear_cache()
  local function _clear_cache(t)
    t.cache = {}
    os.remove(t.path)
  end
  _clear_cache(M.chunks)
  _clear_cache(M.modpaths)
end

local function init_cache()
  local function _init_cache(t)
    if not t.enable then
      return
    end
    if fs_stat(t.path) then
      log("Loading cache file %s", t.path)
      local f = assert(io.open(t.path, "rb"))
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

  if not uv.fs_stat(std_cache) then
    vim.fn.mkdir(std_cache, "p")
  end

  _init_cache(M.chunks)
  _init_cache(M.modpaths)
end

local function setup()
  init_cache()

  -- Usual package loaders
  -- 1. package.preload
  -- 2. vim._load_package
  -- 3. package.path
  -- 4. package.cpath
  -- 5. all-in-one

  -- Override default functions
  for i, loader in ipairs(package.loaders) do
    if loader == vim._load_package then
      package.loaders[i] = load_package
      break
    end
  end
  vim._load_package = load_package

  vim.api.nvim__get_runtime = get_runtime_cached
  loadfile = loadfile_cached

  local augroup = api.nvim_create_augroup("impatient", {})

  api.nvim_create_user_command("LuaCacheClear", clear_cache, {})
  api.nvim_create_user_command("LuaCacheLog", print_log, {})

  api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
    group = augroup,
    callback = M.save_cache,
  })

  api.nvim_create_autocmd("OptionSet", {
    group = augroup,
    pattern = "runtimepath",
    callback = function()
      rtp = vim.split(vim.o.rtp, ",")
    end,
  })
end

setup()

return M
