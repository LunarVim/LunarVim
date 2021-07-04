local first_run = CACHE_PATH .. "first_run"

-- Run PackerCompile after PackerInstall has completed during install phase
if fn.isfile(first_run) != 0 then
  vim.cmd "autocmd User PackerComplete ++once PackerCompile"
  fn.system { "rm", first_run }
end
