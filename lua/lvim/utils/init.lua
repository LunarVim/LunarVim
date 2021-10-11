local utils = {}
local Log = require "lvim.core.log"
local uv = vim.loop

-- recursive Print (structure, limit, separator)
local function r_inspect_settings(structure, limit, separator)
  limit = limit or 100 -- default item limit
  separator = separator or "." -- indent string
  if limit < 1 then
    print "ERROR: Item limit reached."
    return limit - 1
  end
  if structure == nil then
    io.write("-- O", separator:sub(2), " = nil\n")
    return limit - 1
  end
  local ts = type(structure)

  if ts == "table" then
    for k, v in pairs(structure) do
      -- replace non alpha keys with ["key"]
      if tostring(k):match "[^%a_]" then
        k = '["' .. tostring(k) .. '"]'
      end
      limit = r_inspect_settings(v, limit, separator .. "." .. tostring(k))
      if limit < 0 then
        break
      end
    end
    return limit
  end

  if ts == "string" then
    -- escape sequences
    structure = string.format("%q", structure)
  end
  separator = separator:gsub("%.%[", "%[")
  if type(structure) == "function" then
    -- don't print functions
    io.write("-- lvim", separator:sub(2), " = function ()\n")
  else
    io.write("lvim", separator:sub(2), " = ", tostring(structure), "\n")
  end
  return limit - 1
end

function utils.generate_settings()
  -- Opens a file in append mode
  local file = io.open("lv-settings.lua", "w")

  -- sets the default output file as test.lua
  io.output(file)

  -- write all `lvim` related settings to `lv-settings.lua` file
  r_inspect_settings(lvim, 10000, ".")

  -- closes the open file
  io.close(file)
end

-- autoformat
function utils.toggle_autoformat()
  if lvim.format_on_save then
    require("lvim.core.autocmds").define_augroups {
      autoformat = {
        {
          "BufWritePre",
          "*",
          ":silent lua vim.lsp.buf.formatting_sync()",
        },
      },
    }
    Log:debug "Format on save active"
  end

  if not lvim.format_on_save then
    vim.cmd [[
      if exists('#autoformat#BufWritePre')
        :autocmd! autoformat
      endif
    ]]
    Log:debug "Format on save off"
  end
end

function utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function utils.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

--- Returns a table with the default values that are missing.
--- either paramter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function utils.apply_defaults(config, default_config)
  config = config or {}
  default_config = default_config or {}
  local new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), config)
  new_config = vim.tbl_deep_extend("keep", new_config, default_config)
  return new_config
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function utils.is_file(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function utils.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

utils.join_paths = _G.join_paths

function utils.write_file(path, txt, flag)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, txt, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

function utils.debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

function utils.search_file(file, args)
  local Job = require "plenary.job"
  local stderr = {}
  local stdout, ret = Job
    :new({
      command = "grep",
      args = { args, file },
      cwd = get_cache_dir(),
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()
  return stdout, ret, stderr
end

function utils.file_contains(file, query)
  local stdout, ret, stderr = utils.search_file(file, query)
  if ret == 0 then
    return true
  end
  if not vim.tbl_isempty(stderr) then
    error(vim.inspect(stderr))
  end
  if not vim.tbl_isempty(stdout) then
    error(vim.inspect(stdout))
  end
  return false
end

function utils.log_contains(query)
  local logfile = require("lvim.core.log"):get_path()
  local stdout, ret, stderr = utils.search_file(logfile, query)
  if ret == 0 then
    return true
  end
  if not vim.tbl_isempty(stderr) then
    error(vim.inspect(stderr))
  end
  if not vim.tbl_isempty(stdout) then
    error(vim.inspect(stdout))
  end
  if not vim.tbl_isempty(stderr) then
    error(vim.inspect(stderr))
  end
  return false
end

return utils

-- TODO: find a new home for these autocommands
