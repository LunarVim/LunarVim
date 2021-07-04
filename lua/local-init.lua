-- Permit loading vim config from outside the LunarVim managed nvim dir
-- but default to loading CONFIG_PATH/init-user.lua, if it exists..
local function nvim_user_init_root()
    local _nvim_user_init_root = os.getenv("NVIM_USER_INIT_ROOT")

    local path

    if _nvim_user_init_root == nil then
        path = CONFIG_PATH
    else
        path = _nvim_user_init_root
    end

    return path
end

local user_init = nvim_user_init_root() .. "/init-user.lua"

if vim.fn.filereadable(user_init) == 1 then
    package.path = package.path .. ';' .. nvim_user_init_root() .. '/?.lua'
    require('init-user')
end
