local M = {}

-- autoformat
if O.format_on_save then
  require("lv-utils").define_augroups {
    autoformat = {
      {
        "BufWritePost",
        "*",
        ":silent FormatWrite",
      },
    },
  }
end

M.setup = function(filetype)
  O.formatters.filetype[filetype] = {
    function()
      return {
        exe = O.lang[filetype].formatter.exe,
        args = O.lang[filetype].formatter.args,
        stdin = O.lang[filetype].formatter.stdin,
        tempfile_prefix = ".formatter",
      }
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.setup_local = function(filetype)
  vim.cmd "let proj = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "proj"

  -- use the global formatter if you didn't find the local one
  local formatter_instance = root_dir .. "/node_modules/.bin/" .. O.lang[filetype].formatter.exe
  if vim.fn.executable(formatter_instance) ~= 1 then
    formatter_instance = O.lang[filetype].formatter.exe
  end

  local ft = vim.bo.filetype
  O.formatters.filetype[ft] = {
    function()
      local lv_utils = require "lv-utils"
      return {
        exe = formatter_instance,
        args = lv_utils.gsub_args(O.lang.vue.formatter.args),
        stdin = O.lang.vue.formatter.stdin,
        tempfile_prefix = ".formatter",
      }
    end,
  }
  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.initialize = function()
  local status_ok, _ = pcall(require, "formatter")
  if not status_ok then
    return
  end

  if not O.format_on_save then
    vim.cmd [[if exists('#autoformat#BufWritePost')
	:autocmd! autoformat
	endif]]
  end
end

return M
