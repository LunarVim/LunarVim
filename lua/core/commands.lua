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
  [[command! LvimInfo lua require('core.info').toggle_popup(vim.bo.filetype)]],
  [[ command! LvimCacheReset lua require('utils').lvim_cache_reset() ]],
  [[ command! LvimUpdate lua require('utils').lvim_update() ]],
}

M.load = function(commands)
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M
