local M = {}
local u = require "utils"
local null_ls = require "null-ls"

local nodejs_local_providers = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }

M.requested_providers = {}

function M.get_registered_providers_by_filetype(ft)
  local matches = {}
  for _, provider in pairs(M.requested_providers) do
    if vim.tbl_contains(provider.filetypes, ft) then
      local provider_name = provider.name
      -- special case: show "eslint_d" instead of eslint
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
      if string.find(provider._opts.command, "eslint_d") then
        provider_name = "eslint_d"
      end
      table.insert(matches, provider_name)
    end
  end

  return matches
end

local function validate_nodejs_provider(requests, provider)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_nodejs_command = root_dir .. "/node_modules/.bin/" .. provider._opts.command
  u.lvim_log(string.format("checking for local node module: [%s]", vim.inspect(provider)))
  if vim.fn.executable(local_nodejs_command) == 1 then
    provider._opts.command = local_nodejs_command
    table.insert(requests, provider)
  elseif vim.fn.executable(provider._opts.command) == 1 then
    u.lvim_log(string.format("checking in global path instead for node module: [%s]", provider._opts.command))
    table.insert(requests, provider)
  else
    u.lvim_log(string.format("Unable to find node module: [%s]", provider._opts.command))
    return false
  end
  return true
end

local function validate_provider_request(requests, provider)
  if provider == "" or provider == nil then
    return false
  end
  -- NOTE: we can't use provider.name because eslint_d uses eslint name
  if vim.tbl_contains(nodejs_local_providers, provider._opts.command) then
    return validate_nodejs_provider(requests, provider)
  end
  if vim.fn.executable(provider._opts.command) ~= 1 then
    u.lvim_log(string.format("Unable to find the path for: [%s]", vim.inspect(provider)))
    return false
  end
  table.insert(requests, provider)
  return true
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  for _, formatter in pairs(lvim.lang[filetype].formatters) do
    local builtin_formatter = null_ls.builtins.formatting[formatter.exe]
    -- FIXME: why doesn't this work?
    -- builtin_formatter._opts.args = formatter.args or builtin_formatter._opts.args
    -- builtin_formatter._opts.to_stdin = formatter.stdin or builtin_formatter._opts.to_stdin
    if validate_provider_request(M.requested_providers, builtin_formatter) then
      u.lvim_log(string.format("Using format provider: [%s]", formatter.exe))
    end
  end

  for _, linter in pairs(lvim.lang[filetype].linters) do
    local builtin_diagnoser = null_ls.builtins.diagnostics[linter.exe]
    -- special case: fallback to "eslint"
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
    -- if provider.exe
    if linter.exe == "eslint_d" then
      builtin_diagnoser = null_ls.builtins.diagnostics.eslint.with { command = "eslint_d" }
    end
    -- FIXME: why doesn't this work?
    -- builtin_diagnoser._opts.args = linter.args or builtin_diagnoser._opts.args
    -- builtin_diagnoser._opts.to_stdin = linter.stdin or builtin_diagnoser._opts.to_stdin
    if validate_provider_request(M.requested_providers, builtin_diagnoser) then
      u.lvim_log(string.format("Using linter provider: [%s]", linter.exe))
    end
  end

  null_ls.register { sources = M.requested_providers }
end

return M
