local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
telescope.setup(O.plugin.telescope)
vim.api.nvim_set_keymap("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
