local M = {}

local null_ls = require "null-ls"
--

-- use the global formatter if you didn't find the local one
-- if vim.fn.executable(formatter_instance) ~= 1 then
-- formatter_instance = O.lang[filetype].formatter.exe
-- end
-- null_ls.builtins.formatting.prettier,
-- smart_prettier,
-- null_ls.builtins.diagnostics.write_good,
-- null_ls.builtins.code_actions.gitsigns,

local find_local_exe = function(exe)
  vim.cmd "let root_dir = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "root_dir"
  local local_exe = root_dir .. "/node_modules/.bin/" .. exe
  return local_exe
end

local sources = {}

-- TODO: loop through all langs that care about prettier and eslint
-- TODO both linters and formatters here

function M.setup(filetype)
  if O.lang[filetype].formatter.exe == "prettier" then
    local smart_prettier = null_ls.builtins.formatting.prettier
    local formatter_instance = find_local_exe "prettier"
    if vim.fn.executable(formatter_instance) then
      smart_prettier._opts.command = formatter_instance
    end
    table.insert(sources, smart_prettier)
  end
end

return M
-- null_ls.config { sources = sources }
