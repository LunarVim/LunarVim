local M = {}
local u = require "utils"
local null_ls = require "null-ls"

<<<<<<< HEAD
local nodejs_local_providers = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }

M.requested_providers = {}
=======
local _, null_ls = pcall(require, "null-ls")
local sources = {}

local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }
local executable_name_map = {
  eslint_d = "eslint",
}
>>>>>>> b8f4b5a (Unbloat code)

function M.get_registered_providers_by_filetype(ft)
  local matches = {}
  for _, provider in pairs(M.requested_providers) do
    if vim.tbl_contains(provider.filetypes, ft) then
      table.insert(matches, provider.name)
    end
  end

  return matches
end

local function is_nodejs_provider(provider)
  for _, local_provider in ipairs(nodejs_local_providers) do
    if local_provider == provider.exe then
      return true
    end
  end
  return false
end

<<<<<<< HEAD
local function is_provider_found(provider)
  -- special case: fallback to "eslint"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
  provider._opts.command = provider._opts.command == "eslint_d" and "eslint" or provider._opts.command

  local retval = { is_local = false, path = nil }
  if vim.fn.executable(provider._opts.command) == 1 then
    return false, provider._opts.command
  end
  if is_nodejs_provider(provider) then
    vim.cmd "let root_dir = FindRootDirectory()"
    local root_dir = vim.api.nvim_get_var "root_dir"
    local local_provider_command = root_dir .. "/node_modules/.bin/" .. provider._opts.command
    if vim.fn.executable(local_provider_command) == 1 then
      retval.is_local = true
      retval.path = local_provider_command
    end
  end
  return retval.is_local, retval.path
end

local function validate_provider(provider)
  local is_local, provider_path = is_provider_found(provider)
  if not provider_path then
    u.lvim_log(string.format("Unable to find the path for: [%s]", provider))
    return false
=======
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
local get_normalized_exe = function(exe, null_ls_builtins)
  if not null_ls_builtins[exe] and executable_name_map[exe] then
    return null_ls_builtins[executable_name_map[exe]]
  end
  return null_ls_builtins[exe]
end

local function setup_ls(exe, null_ls_builtins)
  if vim.tbl_contains(local_executables, exe) then
    local smart_executable = get_normalized_exe(exe, null_ls_builtins)
    local local_executable = find_local_exe(exe)
    if vim.fn.executable(local_executable) == 1 then
      smart_executable._opts.command = local_executable
      table.insert(sources, smart_executable)
    elseif vim.fn.executable(exe) == 1 then
      smart_executable._opts.command = exe
      table.insert(sources, smart_executable)
    end
  elseif null_ls_builtins[exe] and vim.fn.executable(null_ls_builtins[exe]._opts.command) then
    table.insert(sources, null_ls_builtins[exe])
>>>>>>> b8f4b5a (Unbloat code)
  end
  if is_local then
    provider._opts.command = provider_path
  end
  return true
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
<<<<<<< HEAD
function M.setup(filetype)
  for _, formatter in pairs(lvim.lang[filetype].formatters) do
    local builtin_formatter = null_ls.builtins.formatting[formatter.exe]
    -- FIXME: why doesn't this work?
    -- builtin_formatter._opts.args = formatter.args or builtin_formatter._opts.args
    -- builtin_formatter._opts.to_stdin = formatter.stdin or builtin_formatter._opts.to_stdin
    table.insert(M.requested_providers, builtin_formatter)
    u.lvim_log(string.format("Using format provider: [%s]", formatter.exe))
  end

  for _, linter in pairs(lvim.lang[filetype].linters) do
    local builtin_diagnoser = null_ls.builtins.diagnostics[linter.exe]
    -- FIXME: why doesn't this work?
    -- builtin_diagnoser._opts.args = linter.args or builtin_diagnoser._opts.args
    -- builtin_diagnoser._opts.to_stdin = linter.stdin or builtin_diagnoser._opts.to_stdin
    table.insert(M.requested_providers, builtin_diagnoser)
    u.lvim_log(string.format("Using linter provider: [%s]", linter.exe))
  end

  for idx, provider in pairs(M.requested_providers) do
    if not validate_provider(provider) then
      table.remove(M.requested_providers, idx)
    end
  end
  null_ls.register { sources = M.requested_providers }
=======
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
>>>>>>> b8f4b5a (Unbloat code)
end

return M
