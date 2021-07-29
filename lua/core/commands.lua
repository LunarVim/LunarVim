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

  -- Save files
  -- Save file without formatting the file
  [[command! -bang -bar SaveWithoutFormatting lua require 'utils'.save_file(false, "<bang>" == "!")]],
  -- Save file and also format the file
  [[command! -bang -bar SaveWithFormatting  lua require 'utils'.save_file(true, "<bang>" == "!")]],
  -- Save file but respect auto format settings
  [[command! -bang -bar SaveFile lua require 'utils'.save_file(nil, "<bang>" == "!")]],

  -- Like above command but also quit immediately
  [[command! -bang -bar SaveWithoutFormattingAndQuit lua require 'utils'.save_file(false, "<bang>" == "!", true)]],
  [[command! -bang -bar SaveWithFormattingAndQuit  lua require 'utils'.save_file(true, "<bang>" == "!", true)]],
  [[command! -bang -bar SaveFileAndQuit lua require 'utils'.save_file(nil, "<bang>" == "!", true)]],

  -- Map vim commands to our new commands
  [[cnoreabbrev w SaveFile]],
  [[cnoreabbrev w! SaveFile!]],
  [[cnoreabbrev wq SaveFileAndQuit]],
  [[cnoreabbrev wq! SaveFileAndQuit!]],
}

M.load = function(commands)
  for _, command in ipairs(commands) do
    vim.cmd(command)
  end
end

return M
