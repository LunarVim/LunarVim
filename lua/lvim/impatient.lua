-- modified version from https://github.com/lewis6991/impatient.nvim

local vim = vim
local uv = vim.loop
local impatient_load_start = uv.hrtime()
local api = vim.api
local ffi = require "ffi"

local get_option, set_option = api.nvim_get_option, api.nvim_set_option
local get_runtime_file = api.nvim_get_runtime_file

local impatient_dur

local M = {
  cache = {},
  profile = nil,
  dirty = false,
  path = nil,
  log = {},
}

_G.__luacache = M

--{{{
local cachepack = {}

-- using double for packing/unpacking numbers has no conversion overhead
-- 32-bit ARM causes a bus error when casting to double, so use int there
local number_t = jit.arch ~= "arm" and "double" or "int"
ffi.cdef("typedef " .. number_t .. " number_t;")

local c_number_t = ffi.typeof "number_t[1]"
local c_sizeof_number_t = ffi.sizeof "number_t"

local out_buf = {}

function out_buf.write_number(buf, num)
  buf[#buf + 1] = ffi.string(c_number_t(num), c_sizeof_number_t)
end

function out_buf.write_string(buf, str)
  out_buf.write_number(buf, #str)
  buf[#buf + 1] = str
end

function out_buf.to_string(buf)
  return table.concat(buf)
end

local in_buf = {}

function in_buf.read_number(buf)
  if buf.size < buf.pos then
    error "buffer access violation"
  end
  local res = ffi.cast("number_t*", buf.ptr + buf.pos)[0]
  buf.pos = buf.pos + c_sizeof_number_t
  return res
end

function in_buf.read_string(buf)
  local len = in_buf.read_number(buf)
  local res = ffi.string(buf.ptr + buf.pos, len)
  buf.pos = buf.pos + len

  return res
end

function cachepack.pack(cache)
  local total_keys = vim.tbl_count(cache)
  local buf = {}

  out_buf.write_number(buf, total_keys)
  for k, v in pairs(cache) do
    out_buf.write_string(buf, k)
    out_buf.write_string(buf, v[1] or "")
    out_buf.write_number(buf, v[2] or 0)
    out_buf.write_string(buf, v[3] or "")
  end

  return out_buf.to_string(buf)
end

function cachepack.unpack(str, raw_buf_size)
  if raw_buf_size == 0 or str == nil or (raw_buf_size == nil and #str == 0) then
    return {}
  end

  local buf = {
    ptr = raw_buf_size and str or ffi.new("const char[?]", #str, str),
    pos = 0,
    size = raw_buf_size or #str,
  }
  local cache = {}

  local total_keys = in_buf.read_number(buf)
  for _ = 1, total_keys do
    local k = in_buf.read_string(buf)
    local v = {
      in_buf.read_string(buf),
      in_buf.read_number(buf),
      in_buf.read_string(buf),
    }
    cache[k] = v
  end

  return cache
end
--}}}

local function log(...)
  M.log[#M.log + 1] = table.concat({ string.format(...) }, " ")
end

function M.print_log()
  for _, l in ipairs(M.log) do
    print(l)
  end
end

function M.enable_profile()
  M.profile = {}
  M.print_profile = function()
    M.profile["lvim.impatient"] = {
      resolve = 0,
      load = impatient_dur,
      loader = "standard",
    }
    require("lvim.impatient.profile").print_profile(M.profile)
  end
  vim.cmd [[command! LuaCacheProfile lua _G.__luacache.print_profile()]]
end

local function is_cacheable(path)
  -- Don't cache files in /tmp since they are not likely to persist.
  -- Note: Appimage versions of Neovim mount $VIMRUNTIME in /tmp in a unique
  -- directory on each launch.
  return not vim.startswith(path, "/tmp/")
end

local function hash(modpath)
  local stat = uv.fs_stat(modpath)
  if stat then
    return stat.mtime.sec
  end
end

local function hrtime()
  if M.profile then
    return uv.hrtime()
  end
end

local function load_package_with_cache(name, loader)
  local resolve_start = hrtime()

  local basename = name:gsub("%.", "/")
  local paths = { "lua/" .. basename .. ".lua", "lua/" .. basename .. "/init.lua" }

  for _, path in ipairs(paths) do
    local modpath = get_runtime_file(path, false)[1]
    if modpath then
      local load_start = hrtime()
      local chunk, err = loadfile(modpath)

      if M.profile then
        M.profile[name] = {
          resolve = load_start - resolve_start,
          load = hrtime() - load_start,
          loader = loader or "standard",
        }
      end

      if chunk == nil then
        return err
      end

      if is_cacheable(modpath) then
        log("Creating cache for module %s", name)
        M.cache[name] = { modpath, hash(modpath), string.dump(chunk) }
        M.dirty = true
      else
        log("Unable to cache module %s", name)
      end

      return chunk
    end
  end
  return nil
end

local reduced_rtp

-- Speed up non-cached loads by reducing the rtp path during requires
function M.update_reduced_rtp()
  local luadirs = get_runtime_file("lua/", true)

  for i = 1, #luadirs do
    luadirs[i] = luadirs[i]:sub(1, -6)
  end

  reduced_rtp = table.concat(luadirs, ",")
end

local function load_package_with_cache_reduced_rtp(name)
  local orig_rtp = get_option "runtimepath"
  local orig_ei = get_option "eventignore"

  if not reduced_rtp then
    M.update_reduced_rtp()
  end

  set_option("eventignore", "all")
  set_option("rtp", reduced_rtp)

  local found = load_package_with_cache(name, "reduced")

  set_option("rtp", orig_rtp)
  set_option("eventignore", orig_ei)

  return found
end

local function load_from_cache(name)
  local resolve_start = hrtime()
  if M.cache[name] == nil then
    log("No cache for module %s", name)
    return "No cache entry"
  end

  local modpath, mhash, codes = unpack(M.cache[name])

  if mhash ~= hash(modpath) then
    log("Stale cache for module %s", name)
    M.cache[name] = nil
    M.dirty = true
    return "Stale cache"
  end

  local load_start = hrtime()
  local chunk = loadstring(codes)

  if M.profile then
    M.profile[name] = {
      resolve = load_start - resolve_start,
      load = hrtime() - load_start,
      loader = "cache",
    }
  end

  if not chunk then
    M.cache[name] = nil
    M.dirty = true
    log("Error loading cache for module. Invalidating", name)
    return "Cache error"
  end

  return chunk
end

function M.save_cache()
  if M.dirty then
    log("Updating cache file: %s", M.path)
    local f = io.open(M.path, "w+b")
    f:write(cachepack.pack(M.cache))
    f:flush()
    M.dirty = false
  end
end

function M.clear_cache()
  M.cache = {}
  os.remove(M.path)
end

impatient_dur = uv.hrtime() - impatient_load_start

function M.setup(opts)
  opts = opts or {}
  M.path = opts.path or vim.fn.stdpath "cache" .. "/lvim_cache"

  if opts.enable_profiling then
    M.enable_profile()
  end

  local impatient_setup_start = uv.hrtime()
  local stat = uv.fs_stat(M.path)
  if stat then
    log("Loading cache file %s", M.path)
    local ok
    -- Linux/macOS lets us easily mmap the cache file for faster reads without passing to Lua
    if jit.os == "Linux" or jit.os == "OSX" then
      local size = stat.size

      local C = ffi.C
      local O_RDONLY = 0x00
      local PROT_READ = 0x01
      local MAP_PRIVATE = 0x02

      ffi.cdef [[
      int open(const char *pathname, int flags);
      int close(int fd);
      void *mmap(void *addr, size_t length, int prot, int flags, int fd, long int offset);
      int munmap(void *addr, size_t length);
      ]]
      local f = C.open(M.path, O_RDONLY)

      local addr = C.mmap(nil, size, PROT_READ, MAP_PRIVATE, f, 0)
      ok = ffi.cast("intptr_t", addr) ~= -1

      if ok then
        M.cache = cachepack.unpack(ffi.cast("char *", addr), size)
        C.munmap(addr, size)
      end

      C.close(f)
    else
      local f = io.open(M.path, "rb")
      ok, M.cache = pcall(function()
        return cachepack.unpack(f:read "*a")
      end)
    end

    if not ok then
      log("Corrupted cache file, %s. Invalidating...", M.path)
      os.remove(M.path)
      M.cache = {}
    end
    M.dirty = not ok
  end

  local insert = table.insert
  local package = package

  -- Fix the position of the preloader. This also makes loading modules like 'ffi'
  -- and 'bit' quicker
  if package.loaders[1] == vim._load_package then
    -- Move vim._load_package to the second position
    local vim_load = table.remove(package.loaders, 1)
    insert(package.loaders, 2, vim_load)
  end

  insert(package.loaders, 2, load_from_cache)
  insert(package.loaders, 3, load_package_with_cache_reduced_rtp)
  insert(package.loaders, 4, load_package_with_cache)

  vim.cmd [[
    augroup impatient
      autocmd VimEnter,VimLeave * lua _G.__luacache.save_cache()
      autocmd OptionSet runtimepath lua _G.__luacache.update_reduced_rtp(true)
    augroup END

    command! LuaCacheClear lua _G.__luacache.clear_cache()
    command! LuaCacheLog   lua _G.__luacache.print_log()
  ]]

  impatient_dur = impatient_dur + (uv.hrtime() - impatient_setup_start)
end

return M
