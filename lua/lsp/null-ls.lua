local M = {}

local _, null_ls = pcall(require, "null-ls")
local utils = require "utils"
local sources = {}

local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }

local find_local_exe = function(exe)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_exe = root_dir .. "/node_modules/.bin/" .. exe
  return local_exe
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
local get_normalized_exe = function(exe, type)
  if type == "diagnostics" and exe == "eslint_d" then
    return "eslint"
  end
  return exe
end

local function setup_ls(exe, type)
  if utils.has_value(local_executables, exe) then
    local normalized_exe = get_normalized_exe(exe, type)
    local smart_executable = null_ls.builtins[type][normalized_exe]
    local local_executable = find_local_exe(exe)
    if vim.fn.executable(local_executable) == 1 then
      smart_executable._opts.command = local_executable
      table.insert(sources, smart_executable)
    else
      if vim.fn.executable(exe) == 1 then
        smart_executable._opts.command = exe
        table.insert(sources, smart_executable)
      end
    end
  else
    if null_ls.builtins[type][exe] and vim.fn.executable(null_ls.builtins[type][exe]._opts.command) then
      table.insert(sources, null_ls.builtins[type][exe])
    end
  end
  null_ls.register { sources = sources }
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
local function setup(filetype, type)
  local executables = nil
  if type == "diagnostics" then
    executables = lvim.lang[filetype].linters
  end
  if type == "formatting" then
    executables = lvim.lang[filetype].formatter.exe
  end

  if utils.is_table(executables) then
    for _, exe in pairs(executables) do
      if exe ~= "" then
        setup_ls(exe, type)
      end
    end
  end
  if utils.is_string(executables) and executables ~= "" then
    setup_ls(executables, type)
  end
end

-- TODO: return the formatter if one was registered, then turn off the builtin formatter
function M.setup(filetype)
  setup(filetype, "formatting")
  setup(filetype, "diagnostics")
  lvim.sources = sources
  return sources
end

return M
