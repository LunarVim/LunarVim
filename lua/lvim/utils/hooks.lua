local M = {}

local Log = require "lvim.core.log"
local in_headless = #vim.api.nvim_list_uis() == 0

function M.run_pre_update()
  Log:debug "Starting pre-update hook"
  _G.__luacache.clear_cache()
end

---Reset any startup cache files used by Packer and Impatient
---Tip: Useful for clearing any outdated settings
function M.reset_cache()
  _G.__luacache.clear_cache()
  require("lvim.plugin-loader"):cache_reset()
end

function M.run_post_update()
  M.reset_cache()
  Log:debug "Starting post-update hook"
  package.loaded["lvim.lsp.templates"] = nil
  require("lvim.lsp.templates").generate_templates()

  if not in_headless then
    vim.schedule(function()
      require("packer").install()
      -- TODO: add a changelog
      vim.notify("Update complete", vim.log.levels.INFO)
      vim.cmd "LspStart"
    end)
  end
end

return M
