local M = {
  langs = {
    -- [...] = {
    --   registered = {
    --     formatters = {},
    --     linters = {},
    --   },
    --   errors = {
    --     formatters = {},
    --     linters = {},
    --   },
    -- },
  },
}

local logger = require("core.log"):get_default()
local null_ls = require "null-ls"

local function find_local_node_package(root_dir, command)
  return root_dir .. "/node_modules/.bin/" .. command
end

local local_installations = {
  prettier = find_local_node_package,
  prettierd = find_local_node_package,
  prettier_d_slim = find_local_node_package,
  eslint_d = find_local_node_package,
  eslint = find_local_node_package,
}

local function find_root_dir()
  if lvim.builtin.rooter.active then
    --- use vim-rooter to set root_dir
    vim.cmd "let root_dir = FindRootDirectory()"
    return vim.api.nvim_get_var "root_dir"
  end

  -- TODO: Rework this to not make it javascript specific
  --- use LSP to set root_dir
  local ts_client = require("utils").get_active_client_by_ft "typescript"
  if ts_client == nil then
    logger.error "Unable to determine root directory since tsserver didn't start correctly"
    return nil
  end

  return ts_client.config.root_dir
end

local function find_command(command)
  if local_installations[command] then
    local root_dir = find_root_dir()
    local local_command = local_installations[command](root_dir, command)
    if vim.fn.executable(local_command) == 1 then
      return local_command
    end
  end

  if vim.fn.executable(command) == 1 then
    return command
  end
  return nil
end

local function adapt_linter(linter)
  -- special case: fallback to "eslint"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
  if linter.exe == "eslint_d" then
    return null_ls.builtins.diagnostics.eslint.with { command = "eslint_d" }
  end
  return null_ls.builtins.diagnostics[linter.exe]
end

function M.registered_providers_name(ft)
  local names = {}

  for _, providers in pairs(M.langs[ft].registered) do
    for _, provider in ipairs(providers) do
      table.insert(names, provider.name)
    end
  end
  return names
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  if not M.langs[filetype] then
    M.langs[filetype] = {
      registered = {
        formatters = {},
        linters = {},
      },
      errors = {
        formatters = {},
        linters = {},
      },
    }
  end

  for _, formatter in ipairs(lvim.lang[filetype].formatters) do
    local builtin_formatter = null_ls.builtins.formatting[formatter.exe]
    if not builtin_formatter then
      logger.error("Not a valid formatter:", formatter.exe)
    elseif not vim.tbl_contains(M.langs[filetype].registered.formatters, builtin_formatter) then
      local formatter_cmd = find_command(builtin_formatter._opts.command)
      if not formatter_cmd then
        logger.warn("Not found:", builtin_formatter._opts.command)
        table.insert(M.langs[filetype].errors.formatters, formatter.exe)
      else
        logger.info("Using formatter:", formatter_cmd)
        table.insert(M.langs[filetype].registered.formatters, builtin_formatter.with { command = formatter_cmd })
      end
    end
  end

  for _, linter in pairs(lvim.lang[filetype].linters) do
    local builtin_linter = adapt_linter(linter)
    if not builtin_linter then
      logger.error("Not a valid linter:", linter.exe)
    elseif not vim.tbl_contains(M.langs[filetype].registered.linters, builtin_linter) then
      local linter_cmd = find_command(builtin_linter._opts.command)
      if not linter_cmd then
        logger.warn("Not found:", builtin_linter._opts.command)
        table.insert(M.langs[filetype].errors.linters, linter.exe)
      else
        logger.info("Using linter:", linter_cmd)
        table.insert(M.langs[filetype].registered.linters, builtin_linter.with { command = linter_cmd })
      end
    end
  end

  for _, sources in pairs(M.langs[filetype].registered) do
    null_ls.register { sources = sources }
  end
end

return M
