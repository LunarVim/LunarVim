vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-x>", ":BufferClose<CR>", { noremap = true, silent = true })

O.user_which_key["b"] = {
  name = "Buffers",
  j = { "<cmd>BufferPick<cr>", "jump to buffer" },
  f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
  w = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
  e = {
    "<cmd>BufferCloseAllButCurrent<cr>",
    "close all but current buffer",
  },
  h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
  l = {
    "<cmd>BufferCloseBuffersRight<cr>",
    "close all BufferLines to the right",
  },
  D = {
    "<cmd>BufferOrderByDirectory<cr>",
    "sort BufferLines automatically by directory",
  },
  L = {
    "<cmd>BufferOrderByLanguage<cr>",
    "sort BufferLines automatically by language",
  },
}
