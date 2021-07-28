local M = {}

local null_ls = require "null-ls"
local sources = {}

local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }

local find_local_exe = function(exe)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_exe = root_dir .. "/node_modules/.bin/" .. exe
  return local_exe
end

local function setup_ls(exe, null_ls_builtins)
  if vim.tbl_contains(local_executables, exe) then
    local smart_executable = null_ls_builtins[exe]
    local local_executable = find_local_exe(exe)
    if vim.fn.executable(local_executable) == 1 then
      smart_executable._opts.command = local_executable
      table.insert(sources, smart_executable)
    elseif vim.fn.executable(exe) == 1 then
      table.insert(sources, smart_executable)
    end
  elseif null_ls_builtins[exe] and vim.fn.executable(null_ls_builtins[exe]._opts.command) then
    table.insert(sources, null_ls_builtins[exe])
  end
  null_ls.register { sources = sources }
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
local function setup(null_ls_builtins, executables)
  if type(executables) == "table" then
    for _, exe in pairs(executables) do
      if exe ~= "" then
        setup_ls(exe, null_ls_builtins)
      end
    end
  elseif type(executables) == "string" and executables ~= "" then
    setup_ls(executables, null_ls_builtins)
  end
end

-- TODO: return the formatter if one was registered, then turn off the builtin formatter
function M.setup(filetype)
  setup(null_ls.builtins.formatting, lvim.lang[filetype].formatter.exe)
  setup(null_ls.builtins.diagnostics, lvim.lang[filetype].linters)
  return sources
end

return M
