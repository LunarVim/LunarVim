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

function M.run_on_packer_complete()
  require("lvim.plugin-loader").recompile()
  -- forcefully activate nvim-web-devicons
  require("nvim-web-devicons").set_up_highlights()
  Log:info "Reloaded configuration"
end

function M.run_post_reload()
  Log:debug "Starting post-reload hook"
  if package.loaded["lspconfig"] then
    vim.cmd [[ LspRestart ]]
  end

  M.reset_cache()
  require("lvim.plugin-loader").ensure_installed()
end

---Reset any startup cache files used by Packer and Impatient
---It also forces regenerating any template ftplugin files
---Tip: Useful for clearing any outdated settings
function M.reset_cache()
  local impatient = _G.__luacache
  if impatient then
    impatient.clear_cache()
  end
  local lvim_modules = {}
  for module, _ in pairs(package.loaded) do
    if module:match "lvim.core" or module:match "lvim.lsp" then
      package.loaded[module] = nil
      table.insert(lvim_modules, module)
    end
  end
  Log:trace(string.format("Cache invalidated for core modules: { %s }", table.concat(lvim_modules, ", ")))
  require("lvim.lsp.templates").generate_templates()
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
