local M = {}

M.setup = function(filetype, config)
  O.formatters.filetype[filetype] = {
    function()
      return config
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

return M
