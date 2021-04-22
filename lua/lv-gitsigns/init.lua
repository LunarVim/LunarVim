require('gitsigns').setup {
  signs = {
    -- TODO add hl to colorscheme
    add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '契', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '契', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = true,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
        ['n <leader>ps'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>pu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>pr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>pp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>pb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  },
  watch_index = {
    interval = 1000
  },
  current_line_blame = true,
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  use_decoration_api = false
}
