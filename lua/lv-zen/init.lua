local M = {}
M.config = function()
require('true-zen').setup({
  ui = {
    bottom = {
      laststatus = 0,
      ruler = false,
      showmode = false,
      showcmd = false,
      cmdheight = 1,
    },
    top = {
       showtabline = 0,
    },
    left = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  },
  modes = {
    ataraxis = {
      left_padding = 5,
      right_padding = 5,
      top_padding = 1,
      bottom_padding = 1,
      ideal_writing_area_width = 0,
      just_do_it_for_me = false,
      keep_default_fold_fillchars = true,
      custome_bg = "",
      bg_configuration = true,
      affected_higroups = {
        NonText = {},
        FoldColumn = {},
        ColorColumn = {},
        VertSplit = {},
        StatusLine = {},
        StatusLineNC = {},
        SignColumn = {}
      }
    },
    focus = {
      margin_of_error = 5,
      focus_method = "experimental"
    },
  },
  integrations = {
    vim_gitgutter = false,
    galaxyline = true,
    tmux = false,
    gitsigns = false,
    nvim_bufferline = false,
    limelight = false,
    vim_airline = false,
    vim_powerline = false,
    vim_signify = false,
    express_line = false,
  },
  misc = {
    on_off_commands = false,
    ui_elements_commands = false,
    cursor_by_mode = false,
  }
})
end
return M
