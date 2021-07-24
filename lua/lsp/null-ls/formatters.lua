local M = {}

local null_ls = require "null-ls"
local sources = {}

-- TODO: eslint
local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d" }

local function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local find_local_exe = function(exe)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_exe = root_dir .. "/node_modules/.bin/" .. exe
  return local_exe
end

-- TODO: support multiple formatters
function M.setup(filetype)
  exe = O.lang[filetype].formatter.exe
  if has_value(local_executables, exe) then
    local smart_prettier = null_ls.builtins.formatting[exe]
    local formatter_instance = find_local_exe(exe)
    if vim.fn.executable(formatter_instance) then
      smart_prettier._opts.command = formatter_instance
    end
    table.insert(sources, smart_prettier)
  else
    table.insert(sources, null_ls.builtins.formatting[exe])
  end
  print(vim.inspect(sources))
  null_ls.register { sources = sources }
end

return M

-- use the global formatter if you didn't find the local one
-- if vim.fn.executable(formatter_instance) ~= 1 then
-- formatter_instance = O.lang[filetype].formatter.exe
-- end
-- null_ls.builtins.formatting.prettier,
-- smart_prettier,
-- null_ls.builtins.diagnostics.write_good,
