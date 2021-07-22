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
