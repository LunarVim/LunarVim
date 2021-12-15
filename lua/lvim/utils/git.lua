local M = {}

local Log = require "lvim.core.log"

local function git_cmd(opts)
  local plenary_loaded, Job = pcall(require, "plenary.job")
  if not plenary_loaded then
    vim.cmd "packadd plenary.nvim"
    plenary_loaded, Job = pcall(require, "plenary.job")
  end
  if not plenary_loaded then
    return 1
  end

  opts = opts or {}
  opts.cwd = opts.cwd or get_lvim_base_dir()

  local stderr = {}
  local stdout, ret = Job
    :new({
      command = "git",
      args = opts.args,
      cwd = opts.cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()

  if not vim.tbl_isempty(stderr) then
    Log:debug(stderr)
  end

  if not vim.tbl_isempty(stdout) then
    Log:debug(stdout)
  end

  return ret, stdout
end

---Get the current Lunarvim development branch
---@return string|nil
function M.get_lvim_branch()
  local ret, branch = git_cmd { args = { "branch", "--show-current" } }
  if ret ~= 0 or (not branch or branch[1] == "") then
    Log:error "Unable to retrieve the name of the current branch. Check the log for further information"
    return
  end
  return branch[1]
end

---Get currently checked-out tag of Lunarvim
---@param type string can be "short"
---@return string|nil
function M.get_lvim_tag(type)
  type = type or ""
  local ret, results = git_cmd { args = { "describe", "--tags" } }
  local lvim_full_ver = results[1] or ""

  if ret ~= 0 or string.match(lvim_full_ver, "%d") == nil then
    return nil
  end
  if type == "short" then
    return vim.fn.split(lvim_full_ver, "-")[1]
  else
    return string.sub(lvim_full_ver, 1, #lvim_full_ver - 1)
  end
end

---Get the commit hash of currently checked-out commit of Lunarvim
---@param type string can be "short"
---@return string|nil
function M.get_lvim_version(type)
  type = type or ""
  local branch = M.get_lvim_branch()
  if branch == "master" then
    return M.get_lvim_tag(type)
  end
  local ret, log_results = git_cmd { args = { "log", "--pretty=format:%h", "-1" } }
  local abbrev_version = log_results[1] or ""
  if ret ~= 0 or string.match(abbrev_version, "%d") == nil then
    Log:error "Unable to retrieve current version. Check the log for further information"
    return nil
  end
  if type == "short" then
    return abbrev_version
  end
  return branch .. "-" .. abbrev_version
end

function M.generate_plugins_sha(output)
  local list = {}
  output = output or "commits.lua"

  local core_plugins = require "lvim.plugins"
  local Job = require "plenary.job"
  local jobs = {}

  for _, plugin in pairs(core_plugins) do
    local name = plugin[1]:match "/(%S*)"
    local url = "https://github.com/" .. plugin[1]
    print("checking: " .. name .. ", at: " .. url)
    local job = Job:new { command = "git", args = { "ls-remote", url, "HEAD" } }
    job:after_success(function(this_job)
      print("checked " .. name)
      local latest_sha = this_job:result()
      -- replace dashes, remove postfixes and use lowercase
      local normalize_name = (name:gsub("-", "_"):gsub("%.%S+", "")):lower()
      list[normalize_name] = latest_sha[1]:gsub("\tHEAD", "")
    end)
    job:start()
    table.insert(jobs, job)
  end
  Job.join(unpack(jobs))

  require("lvim.utils").write_file(output, "local commit = " .. vim.inspect(list), "w")
end
return M
