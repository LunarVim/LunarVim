vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "<leader>/", "<Plug>kommentary_visual_default", {})
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})
