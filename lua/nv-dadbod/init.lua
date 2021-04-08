vim.api.nvim_set_keymap("n", "<leader>Du", ":DBUIToggle<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>Df", ":DBUIFindBuffer<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>Dr", ":DBUIRenameBuffer<CR>", {noremap=true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>Dl", ":DBUILastQueryInfo<CR>", {noremap=true, silent = true})
vim.g.db_ui_save_location = O.database.save_location
vim.g.db_ui_auto_execute_table_helpers = O.database.auto_execute