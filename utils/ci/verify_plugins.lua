local completed = 0
local collection = {}
local active_jobs = {}

local fmt = string.format
local core_plugins = require "lvim.plugins"

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local fd = io.open(default_snapshot_path, "rb")
local content
if fd then
  content = fd:read "*a"
end
local default_sha1 = vim.json.decode(content)

local get_short_name = function(spec)
  return spec[1]:match "/(%S*)"
end

local get_default_sha1 = function(spec)
  local short_name, _ = get_short_name(spec)
  assert(default_sha1[short_name])
  return default_sha1[short_name].commit
end

local is_directory = require("lvim.utils").is_directory
local lazydir = join_paths(get_runtime_dir(), "site", "pack", "lazy")

local verify_lazy = function()
  if not is_directory(lazydir) then
    io.write "Lazy.nvim not installed!"
    os.exit(1)
  end
  local status_ok, lazy = pcall(require, "lazy")
  if status_ok and lazy then
    return
  end
  io.write "Lazy.nvim not installed!"
  os.exit(1)
end

local get_install_path = function(spec)
  local prefix = join_paths(lazydir, "opt")
  local path = join_paths(prefix, get_short_name(spec))
  return is_directory(path) and path
end

local function call_proc(process, opts, cb)
  local output, error_output = "", ""
  local handle_stdout = function(err, chunk)
    assert(not err, err)
    if chunk then
      output = output .. chunk
    end
  end

  local handle_stderr = function(err, chunk)
    assert(not err, err)
    if chunk then
      error_output = error_output .. chunk
    end
  end

  local uv = vim.loop
  local handle

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local stdio = { nil, stdout, stderr }

  handle = uv.spawn(
    process,
    { args = opts.args, cwd = opts.cwd or uv.cwd(), stdio = stdio },
    vim.schedule_wrap(function(code)
      if code ~= 0 then
        ---@diagnostic disable-next-line: undefined-field
        stdout:read_stop()
        ---@diagnostic disable-next-line: undefined-field
        stderr:read_stop()
      end

      local check = uv.new_check()
      check:start(function()
        for _, pipe in ipairs(stdio) do
          if pipe and not pipe:is_closing() then
            return
          end
        end
        check:stop()
        handle:close()
        cb(code, output, error_output)
      end)
    end)
  )

  uv.read_start(stdout, handle_stdout)
  uv.read_start(stderr, handle_stderr)

  return handle
end

local function verify_core_plugins(verbose)
  for _, spec in pairs(core_plugins) do
    local path = get_install_path(spec)
    if spec.enabled or spec.enabled == nil and path then
      table.insert(collection, {
        name = get_short_name(spec),
        commit = get_default_sha1(spec),
        path = path,
      })
    end
  end

  for _, entry in pairs(collection) do
    local on_done = function(code, result, errors)
      completed = completed + 1
      if code ~= 0 then
        io.write(errors .. "\n")
        -- os.exit(code)
      else
        if verbose then
          io.write(fmt("verified [%s]\n", entry.name))
        end
      end
      local current_commit = result:gsub("\n", ""):gsub([[']], [[]]):sub(1, 7)
      -- just in case there are some extra qutoes or it's a longer commit hash
      if current_commit ~= entry.commit then
        io.write(fmt("mismatch at [%s]: expected [%s], got [%s]\n", entry.name, entry.commit, current_commit))
        os.exit(1)
      end
    end

    local handle = call_proc("git", { args = { "rev-parse", "--short", "HEAD" }, cwd = entry.path }, on_done)
    assert(handle)
    table.insert(active_jobs, handle)
  end

  vim.wait(#active_jobs * 60 * 1000, function()
    ---@diagnostic disable-next-line: redundant-return-value
    return completed == #active_jobs
  end)
end

verify_lazy()
verify_core_plugins()
vim.cmd "q"
