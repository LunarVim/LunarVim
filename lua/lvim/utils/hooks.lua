local M = {}

local Log = require "lvim.core.log"
local in_headless = #vim.api.nvim_list_uis() == 0

function M.run_pre_update()
  Log:debug "Starting pre-update hook"
  if package.loaded["lspconfig"] then
    vim.cmd [[ LspStop ]]
  end
end

function M.run_pre_reload()
  Log:debug "Starting pre-reload hook"
  if package.loaded["lspconfig"] then
    vim.cmd [[ LspStop ]]
  end
end

function M.run_post_reload()
  Log:debug "Starting post-reload hook"
  if package.loaded["lspconfig"] then
    vim.cmd [[ LspRestart ]]
  end

  require("lvim.plugin-loader").ensure_installed()

  -- forcefully activate nvim-web-devicons
  vim.schedule(pcall(function()
    require("nvim-web-devicons").set_up_highlights()
    M.reset_cache()
    Log:info "Reloaded configuration"
  end))
end

---Reset any startup cache files used by Packer and Impatient
---It also forces regenerating any template ftplugin files
---Tip: Useful for clearing any outdated settings
function M.reset_cache()
  _G.__luacache.clear_cache()
  local lvim_modules = {}
  for module, _ in pairs(package.loaded) do
    if module:match "lvim.core" or module:match "lvim.lsp" then
      package.loaded[module] = nil
      table.insert(lvim_modules, module)
    end
  end
  Log:trace(string.format("Cache invalidated for core modules: { %s }", table.concat(lvim_modules, ", ")))
  require("lvim.lsp.templates").generate_templates()
  require("lvim.plugin-loader").recompile()
end

function M.run_post_update()
  Log:debug "Starting post-update hook"
  M.reset_cache()

  Log:debug "Updating core plugins"
  require("lvim.plugin-loader").ensure_installed()

  if not in_headless then
    vim.schedule(function()
      if package.loaded["nvim-treesitter"] then
        vim.cmd [[ TSUpdateSync ]]
      end
      -- TODO: add a changelog
      vim.notify("Update complete", vim.log.levels.INFO)
      if package.loaded["lspconfig"] then
        vim.cmd [[ LspRestart ]]
      end
    end)
  end
end

return M
