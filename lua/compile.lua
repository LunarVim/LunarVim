function file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

local first_run = CACHE_PATH .. "/first_run"

-- Run PackerCompile after PackerInstall has completed during install phase
if file_exists(first_run) then
  vim.cmd "autocmd User PackerComplete ++once PackerCompile"
  vim.fn.system { "rm", first_run }
end
