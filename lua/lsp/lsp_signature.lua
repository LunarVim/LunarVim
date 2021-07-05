local M = {}
M.config = function()
    require "lsp_signature".on_attach({
        -- -- TODO: Maybe delete and call .on_attach() without arguments to use default config
        -- -- Alternative way of configuring (with LspSaga) is commented out bellow
        -- -- It is not as good as default popup configuration (no current argument highlighting)
        -- bind = false,
        -- use_lspsaga = true,
        -- floating_window = true,
        -- fix_pos = false,
        -- hint_enable = true,
        -- hi_parameter = "Search",
        -- handler_opts = {
        --     "shadow"
        -- }
    })
end
return M
