local M = {}

local Log = require "lvim.core.log"
local fmt = string.format
local if_nil = vim.F.if_nil
local text = require "lvim.interface.text"
local banner = require("lvim.core.info").banner

local function git_cmd(opts)
  local plenary_loaded, Job = pcall(require, "plenary.job")
  if not plenary_loaded then
    return 1, { "" }
  end

  opts = opts or {}
  opts.cwd = opts.cwd or get_lvim_base_dir()

  local stderr = {}
  local stdout, ret = Job:new({
    command = "git",
    args = opts.args,
    cwd = opts.cwd,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
  }):sync()

  if not vim.tbl_isempty(stderr) then
    Log:debug(stderr)
  end

  if not vim.tbl_isempty(stdout) then
    Log:debug(stdout)
  end

  return ret, stdout, stderr
end

local function safe_deep_fetch()
  local ret, result, error = git_cmd { args = { "rev-parse", "--is-shallow-repository" } }
  if ret ~= 0 then
    Log:error(vim.inspect(error))
    return
  end
  -- git fetch --unshallow will cause an error on a a complete clone
  local fetch_mode = result[1] == "true" and "--unshallow" or "--all"
  ret = git_cmd { args = { "fetch", fetch_mode } }
  if ret ~= 0 then
    Log:error(fmt "Git fetch %s failed! Please pull the changes manually in %s", fetch_mode, get_lvim_base_dir())
    return
  end
  if fetch_mode == "--unshallow" then
    ret = git_cmd { args = { "remote", "set-branches", "origin", "*" } }
    if ret ~= 0 then
      Log:error(fmt "Git fetch %s failed! Please pull the changes manually in %s", fetch_mode, get_lvim_base_dir())
      return
    end
  end
  return true
end

---pulls the latest changes from github
function M.update_base_lvim()
  Log:info "Checking for updates"

  if not vim.loop.fs_access(get_lvim_base_dir(), "w") then
    Log:warn(fmt("Lunarvim update aborted! cannot write to %s", get_lvim_base_dir()))
    return
  end

  if not safe_deep_fetch() then
    return
  end

  local ret

  ret = git_cmd { args = { "diff", "--quiet", "@{upstream}" } }
  if ret == 0 then
    Log:info "LunarVim is already up-to-date"
    return
  end

  -- Get the messages before merging
  local _, stdout =
    git_cmd { args = { "--no-pager", "log", "--pretty=format:* %h -%d %s (%cr) <%an>", "HEAD..@{upstream}" } }

  local function set_syntax_hl()
    vim.cmd [[highlight LvimInfoIdentifier gui=bold]]
    vim.cmd [[highlight link LvimInfoHeader Type]]
    vim.fn.matchadd("LvimInfoHeader", "changelog:")
    vim.fn.matchadd("LvimInfoHeader", "[0-9a-f]\\{7,8}")
  end

  local content_provider = function(popup)
    local content = {}

    for _, section in ipairs {
      banner,
      { "" },
      { "" },
      { "changelog: " },
      { "" },
      stdout,
      { "" },
    } do
      vim.list_extend(content, section)
    end

    return text.align_left(popup, content, 0.1)
  end

  local Popup = require("lvim.interface.popup"):new {
    win_opts = { number = false },
    buf_opts = { modifiable = false, filetype = "lspinfo" },
  }

  ret = git_cmd { args = { "merge", "--ff-only", "--progress" } }
  if ret ~= 0 then
    Log:error("Update failed! Please pull the changes manually in " .. get_lvim_base_dir())
    return
  end

  -- Display the window after merging
  Popup:display(content_provider)
  set_syntax_hl()

  return true
end

---Switch Lunarvim to the specified development branch
---@param branch string
function M.switch_lvim_branch(branch)
  if not safe_deep_fetch() then
    return
  end
  local args = { "switch", branch }

  if branch:match "^[0-9]" then
    -- avoids producing an error for tags
    vim.list_extend(args, { "--detach" })
  end

  local ret = git_cmd { args = args }
  if ret ~= 0 then
    Log:error "Unable to switch branches! Check the log for further information"
    return
  end
  return true
end

---Get the current Lunarvim development branch
---@return string|nil
function M.get_lvim_branch()
  local _, results = git_cmd { args = { "rev-parse", "--abbrev-ref", "HEAD" } }
  local branch = if_nil(results[1], "")
  return branch
end

---Get currently checked-out tag of Lunarvim
---@return string
function M.get_lvim_tag()
  local args = { "describe", "--tags", "--abbrev=0" }

  local _, results = git_cmd { args = args }
  local tag = if_nil(results[1], "")
  return tag
end

---Get currently running version of Lunarvim
---@return string
function M.get_lvim_version()
  local current_branch = M.get_lvim_branch()

  local lvim_version
  if current_branch ~= "HEAD" or "" then
    lvim_version = current_branch .. "-" .. M.get_lvim_current_sha()
  else
    lvim_version = "v" .. M.get_lvim_tag()
  end
  return lvim_version
end

---Get the commit hash of currently checked-out commit of Lunarvim
---@return string|nil
function M.get_lvim_current_sha()
  local _, log_results = git_cmd { args = { "log", "--pretty=format:%h", "-1" } }
  local abbrev_version = if_nil(log_results[1], "")
  return abbrev_version
end

return M
