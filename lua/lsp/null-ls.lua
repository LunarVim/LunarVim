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

function M.get_missing_providers_by_filetype(ft)
  local matches = {}
  for _, provider in pairs(M.requested_providers) do
    if vim.tbl_contains(provider.filetypes, ft) then
      local provider_name = provider.name

      table.insert(matches, provider_name)
    end
  end

  return matches
end

local function register_failed_request(ft, provider, operation)
  if not lvim.lang[ft][operation]._failed_requests then
    lvim.lang[ft][operation]._failed_requests = {}
  end
  table.insert(lvim.lang[ft][operation]._failed_requests, provider)
end

local function validate_nodejs_provider(provider)
  local command_path
  local root_dir
  if lvim.builtin.rooter.active then
    --- use vim-rooter to set root_dir
    vim.cmd "let root_dir = FindRootDirectory()"
    root_dir = vim.api.nvim_get_var "root_dir"
  else
    --- use LSP to set root_dir
    local ts_client = require("utils").get_active_client_by_ft "typescript"
    if ts_client == nil then
      u.lvim_log "Unable to determine root directory since tsserver didn't start correctly"
      return
    end
    root_dir = ts_client.config.root_dir
  end
  local local_nodejs_command = root_dir .. "/node_modules/.bin/" .. provider._opts.command
  u.lvim_log(string.format("checking [%s] for local node module: [%s]", local_nodejs_command, vim.inspect(provider)))
  if vim.fn.executable(local_nodejs_command) == 1 then
    command_path = local_nodejs_command
  elseif vim.fn.executable(provider._opts.command) == 1 then
    u.lvim_log(string.format("checking in global path instead for node module: [%s]", provider._opts.command))
    command_path = provider._opts.command
  else
    u.lvim_log(string.format("Unable to find node module: [%s]", provider._opts.command))
  end
  return command_path
end

local function validate_provider_request(provider)
  if provider == "" or provider == nil then
    return
  end
  -- NOTE: we can't use provider.name because eslint_d uses eslint name
  if vim.tbl_contains(nodejs_local_providers, provider._opts.command) then
    return validate_nodejs_provider(provider)
  end
  if vim.fn.executable(provider._opts.command) ~= 1 then
    u.lvim_log(string.format("Unable to find the path for: [%s]", vim.inspect(provider)))
    return
  end
  return provider._opts.command
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  for _, formatter in pairs(lvim.lang[filetype].formatters) do
    local builtin_formatter = null_ls.builtins.formatting[formatter.exe]
    if not vim.tbl_contains(M.requested_providers, builtin_formatter) then
      -- FIXME: why doesn't this work?
      -- builtin_formatter._opts.args = formatter.args or builtin_formatter._opts.args
      -- builtin_formatter._opts.to_stdin = formatter.stdin or builtin_formatter._opts.to_stdin
      local resolved_path = validate_provider_request(builtin_formatter)
      if resolved_path then
        builtin_formatter._opts.command = resolved_path
        table.insert(M.requested_providers, builtin_formatter)
        u.lvim_log(string.format("Using format provider: [%s]", builtin_formatter.name))
      else
        -- mark it here to avoid re-doing the lookup again
        register_failed_request(filetype, formatter.exe, "formatters")
      end
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
    if not vim.tbl_contains(M.requested_providers, builtin_diagnoser) then
      -- FIXME: why doesn't this work?
      -- builtin_diagnoser._opts.args = linter.args or builtin_diagnoser._opts.args
      -- builtin_diagnoser._opts.to_stdin = linter.stdin or builtin_diagnoser._opts.to_stdin
      local resolved_path = validate_provider_request(builtin_diagnoser)
      if resolved_path then
        builtin_diagnoser._opts.command = resolved_path
        table.insert(M.requested_providers, builtin_diagnoser)
        u.lvim_log(string.format("Using linter provider: [%s]", builtin_diagnoser.name))
      else
        -- mark it here to avoid re-doing the lookup again
        register_failed_request(filetype, linter.exe, "linters")
      end
    end
  end

  null_ls.register { sources = M.requested_providers }
end

return M
