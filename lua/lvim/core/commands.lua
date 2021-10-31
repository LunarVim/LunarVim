local M = {}

M.defaults = {
  [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
  ]],
  -- :LvimInfo
  [[ command! LvimInfo lua require('lvim.core.info').toggle_popup(vim.bo.filetype) ]],
  [[ command! LvimCacheReset lua require('lvim.utils.hooks').reset_cache() ]],
  [[ command! LvimUpdate lua require('lvim.bootstrap').update() ]],
  [[ command! LvimSyncCorePlugins lua require('lvim.plugin-loader'):sync_core_plugins() ]],
  [[ command! LvimReload lua require('lvim.config'):reload() ]],
}

M.load = function(commands)
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M
