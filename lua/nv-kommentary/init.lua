-- TODO bring back when kommentary works for React
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "<leader>/", "<Plug>kommentary_visual_default", {})

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

-- require('kommentary.config').configure_language("python", {
--     prefer_single_line_comments = true,
-- })

require('kommentary.config').configure_language("javascriptreact", {
    prefer_multi_line_comments = true,
    -- single_line_comment_string = "{/*\\ %s\\ */}",
    multi_line_comment_strings = {"{/*", "*/}"},
})

