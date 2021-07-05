-- allow specifying custom path to lv-config.lua with an environment variable
-- defaults to ~/.config/nvim/lv-config.lua
local function lv_config_file()
    local _lv_config_file = os.getenv("LUNARVIM_LV_CONFIG")
    local path

    if _lv_config_file == nil then
        path = CONFIG_PATH .. "/lv-config.lua"
    else
        path = _lv_config_file
    end

    return path
end

if vim.fn.filereadable(lv_config_file()) == 1 then
    package.path = lv_config_file() .. ';' .. package.path
    vim.cmd("luafile " .. lv_config_file())
end
