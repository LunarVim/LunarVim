vim.api.nvim_set_keymap("n", "<S-x>", ":BufferClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })

O.plugin.which_key.mappings["b"] = {
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

if O.experimental.disable_fancy_icons then
  -- TODO: How to do this initialise `g` lua?
  vim.cmd [[let bufferline = get(g:, 'bufferline', {})]]

  -- TODO: Setting these in lua doesn't seem to work
  -- vim.g.bufferline = {
  --   icon_close_tab = '×',
  --   icon_close_tab_modified = '●',
  --   icons = false
  -- }
  vim.cmd [[let bufferline.icon_close_tab = '×']]
  vim.cmd [[let bufferline.icon_close_tab_modified = '●']]
  vim.cmd [[let bufferline.icons = v:false]]
end

