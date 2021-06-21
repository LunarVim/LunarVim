require('spectre').setup({
 mapping={
    ['toggle_line'] = {
        map = "dd",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item"
    },
    ['enter_file'] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file"
    },
    ['send_to_qf'] = {
        map = "<Blash>q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
    },
    ['replace_cmd'] = {
        map = "<Bslash>c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command"
    },
    ['show_option_menu'] = {
        map = "<Bslash>o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option"
    },
    ['run_replace'] = {
        map = "<Bslash>R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all"
    },
    ['change_view_mode'] = {
        map = "<Bslash>v",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode"
    },
    ['toggle_ignore_case'] = {
      map = "ti",
      cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
      desc = "toggle ignore case"
    },
    ['toggle_ignore_hidden'] = {
      map = "th",
      cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
      desc = "toggle search hidden"
    },
    -- you can put your mapping here it only use normal mode
  }
})

