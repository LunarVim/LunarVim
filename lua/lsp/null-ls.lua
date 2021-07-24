local M = {}

local null_ls = require "null-ls"
local nodejs_local_providers = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }
local requested_providers = {}

local function is_nodejs_provider(provider)
  for _, local_provider in ipairs(nodejs_local_providers) do
    if local_provider == provider then
      return true
    end
  end
  return false
end

local function is_provider_found(provider)
  -- special case: fallback to "eslint"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
  provider = provider == "eslint_d" and "eslint" or provider

  local retval = { is_local = false, path = nil }
  if vim.fn.executable(provider) == 1 then
    return false, provider
  end
  if is_nodejs_provider(provider) then
    vim.cmd "let root_dir = FindRootDirectory()"
    local root_dir = vim.api.nvim_get_var "root_dir"
    local local_provider = root_dir .. "/node_modules/.bin/" .. provider
    if vim.fn.executable(local_provider) == 1 then
      retval.is_local = true
      retval.path = local_provider
    end
  end
  return retval.is_local, retval.path
end

local function enable_provider(filetype, provider)
  local provider_type = "diagnostics" -- this is the most common case
  if provider == lvim.lang[filetype].formatter.exe then
    provider_type = "formatting"
  end

  local is_local, provider_path = is_provider_found(provider)

  if provider_path then
    if is_local then
      null_ls.builtins[provider_type][provider]._opts.command = provider_path
    end
    table.insert(requested_providers, null_ls.builtins[provider_type][provider])
  else
    vim.notify(string.format("Unable to find the path for: [%s]", provider), vim.log.levels.WARN)
  end
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  local sources = {}
  if lvim.lang[filetype].formatter.override_lsp then
    table.insert(sources, lvim.lang[filetype].formatter.exe)
  end

  for _, linter in pairs(lvim.lang[filetype].linters) do
    table.insert(sources, linter)
  end

  for _, provider in pairs(sources) do
    if provider ~= "" then
      enable_provider(filetype, provider)
    end
  end
  null_ls.register { sources = requested_providers }
end

return M
