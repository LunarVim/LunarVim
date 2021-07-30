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

  -- NOTE: Make sure that `<q-args>` is quoted with single quotes only or there will be errors!
  -- Save files
  -- Save file without formatting the file
  [[command! -nargs=* -bang -bar SaveWithoutFormatting lua require 'utils'.save_file(false, "<bang>" == "!", nil, <q-args>)]],
  -- Save file and also format the file
  [[command! -nargs=* -bang -bar SaveWithFormatting  lua require 'utils'.save_file(true, "<bang>" == "!", nil, <q-args>)]],
  -- Save file but respect auto format settings
  [[command! -nargs=* -bang -bar SaveFile lua require 'utils'.save_file(nil, "<bang>" == "!", nil, <q-args>)]],

  -- Like above command but also quit immediately
  [[command! -nargs=* -bang -bar SaveWithoutFormattingAndQuit lua require 'utils'.save_file(false, "<bang>" == "!", true, <q-args>)]],
  [[command! -nargs=* -bang -bar SaveWithFormattingAndQuit  lua require 'utils'.save_file(true, "<bang>" == "!", true, <q-args>)]],
  [[command! -nargs=* -bang -bar SaveFileAndQuit lua require 'utils'.save_file(nil, "<bang>" == "!", true, <q-args>)]],

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
