local sp = os.getenv "SNAPSHOT_PATH"

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
        stdout:read_stop()
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

local plugins_list = {}

local completed = 0

local function write_lockfile(verbose)
  local default_plugins = {}
  local active_jobs = {}

  local core_plugins = require "lvim.plugins"
  for _, plugin in pairs(core_plugins) do
    local name = plugin[1]:match "/(%S*)"
    local url = "https://github.com/" .. plugin[1]
    local commit = ""
    table.insert(default_plugins, {
      name = name,
      url = url,
      commit = commit,
    })
  end

  table.sort(default_plugins, function(a, b)
    return a.name < b.name
  end)

  for _, entry in pairs(default_plugins) do
    local on_done = function(success, result, errors)
      completed = completed + 1
      if not success then
        print("error: " .. errors)
        return
      end
      local latest_sha = result:gsub("\tHEAD\n", ""):sub(1, 7)
      plugins_list[entry.name] = {
        commit = latest_sha,
      }
    end

    local handle = call_proc("git", { args = { "ls-remote", entry.url, "HEAD" } }, on_done)
    assert(handle)
    table.insert(active_jobs, handle)
  end

  print("active: " .. #active_jobs)
  print("plugins: " .. #default_plugins)

  vim.wait(#active_jobs * 60 * 1000, function()
    return completed == #active_jobs
  end)

  if verbose then
    print(vim.inspect(plugins_list))
  end

  local fd = assert(io.open(sp, "w"))
  fd:write(vim.json.encode(plugins_list), "\n")
  fd:flush()
end

write_lockfile()
vim.cmd "q"
