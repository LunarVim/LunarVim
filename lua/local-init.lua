local local_init = CONFIG_PATH .. "../nvim-local/init.lua"

-- Permit loading vim config from outside the LunarVim managed nvim dir
if vim.fn.filereadable(local_init) then
    require(local_init)
end
