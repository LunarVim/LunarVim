local first_run = CACHE_PATH .. "/first_run"

-- Run PackerCompile after PackerInstall has completed during install phase
if vim.fn.filereadable(first_run) then
  vim.cmd "autocmd User PackerComplete ++once PackerCompile"
  vim.fn.system { "rm", first_run }
end
