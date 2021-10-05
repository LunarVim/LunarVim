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
  [[ command! LvimCacheReset lua require('lvim.bootstrap').reset_cache() ]],
  [[ command! LvimUpdate lua require('lvim.bootstrap').update() ]],
}

M.load = function(commands)
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M
