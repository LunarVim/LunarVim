local ffi = require "ffi"

local M = {}

-- using double for packing/unpacking numbers has no conversion overhead
local c_double = ffi.typeof "double[1]"
local sizeof_c_double = ffi.sizeof "double"

local OutputBuffer = {}

function OutputBuffer.create()
  return {}
end

function OutputBuffer.write_number(buf, num)
  buf[#buf + 1] = ffi.string(c_double(num), sizeof_c_double)
end

function OutputBuffer.write_string(buf, str)
  OutputBuffer.write_number(buf, #str)
  buf[#buf + 1] = str
end

function OutputBuffer.to_string(buf)
  return table.concat(buf)
end

local InputBuffer = {}

function InputBuffer.create(str)
  return {
    ptr = ffi.new("const char[?]", #str, str),
    pos = 0,
    size = #str,
  }
end

function InputBuffer.read_number(buf)
  if buf.size < buf.pos then
    error "buffer access violation"
  end
  local res = ffi.cast("double*", buf.ptr + buf.pos)[0]
  buf.pos = buf.pos + sizeof_c_double
  return res
end

function InputBuffer.read_string(buf)
  local len = InputBuffer.read_number(buf)
  local res = ffi.string(buf.ptr + buf.pos, len)
  buf.pos = buf.pos + len

  return res
end

function M.pack(cache)
  _G.__luacache.used_mpack = false
  local total_keys = vim.tbl_count(cache)
  local buf = OutputBuffer.create()

  OutputBuffer.write_number(buf, total_keys)
  for k, v in pairs(cache) do
    OutputBuffer.write_string(buf, k)
    OutputBuffer.write_string(buf, v[1] or "")
    OutputBuffer.write_number(buf, v[2] or 0)
    OutputBuffer.write_string(buf, v[3] or "")
  end

  return OutputBuffer.to_string(buf)
end

function M.unpack(str)
  _G.__luacache.used_mpack = false
  if str == nil or #str == 0 then
    return {}
  end

  local buf = InputBuffer.create(str)
  local cache = {}

  local total_keys = InputBuffer.read_number(buf)
  for _ = 1, total_keys do
    local k = InputBuffer.read_string(buf)
    local v = {
      InputBuffer.read_string(buf),
      InputBuffer.read_number(buf),
      InputBuffer.read_string(buf),
    }
    cache[k] = v
  end

  return cache
end

return M
