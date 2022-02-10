local M = {}

function M.search_file(file, args)
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

function M.file_contains(file, query)
  local stdout, ret, stderr = M.search_file(file, query)
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

function M.log_contains(query)
  local logfile = require("lvim.core.log"):get_path()
  local stdout, ret, stderr = M.search_file(logfile, query)
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

return M
