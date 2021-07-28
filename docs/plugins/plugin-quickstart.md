# Plugin Quickstart

Just paste any of these snippets into `lvim.plugins`, save (`:w`), and it will autoinstall.

## Navigation

### Hop
```lua
{
  "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end,
}
```
### Nvim-lastplace
``` lua
{
  "ethanholz/nvim-lastplace",
    event = "BufRead"
      config = function()
      require'nvim-lastplace'.setup {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit"
        },
        lastplace_open_folds = true
      }
  end,
}
```

### Lightspeed
``` lua
{
  "ggandor/lightspeed.nvim",
    event = "BufRead",
}
```
### rnvimr

### snap

## Git

### gitlinker.nvim

### octo.nvim

### vim-gist

### git-blame.nvim

### diffview.nvim

### vim-fugitive

## Treesitter

### playground

### nvim-ts-autotag

### nvim-ts-rainbow

### nvim-ts-context-commentstring

## Telescope Extensions

### telescope-fzy-native.nvim

## Colorschemes

### lush.nvim

## LSP enhancement

### lsp_signature.nvim

### vim-bundler

### Goto-preview
``` lua
{
  "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
          height = 25; -- Height of the floating window
          default_mappings = false; -- Bind default mappings
          debug = false; -- Print debug information
          opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
          post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
          -- You can use "default_mappings = true" setup option
          -- Or explicitly set keybindings
          -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
          -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
          -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
  end
}
```
## General

### Persistence
```
{
  "folke/persistence.nvim",
    event = "VimEnter",
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
  end,
},
```

Also define keybindings in your `lv-config.lua`
```
  lvim.builtin.which_key.mappings["Q"]= {
    name = "+Quit",
    s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
    l = { "<cmd>lua require('persistence').load(last=true)<cr>", "Restore last session" },
    d = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  }
```
### indent-blankline.nvim

### nvim-colorizer

### dial.nvim

### vim-matchup

### numb.nvim

### nvim-spectre

### nvim-bqf

### markdown-preview.nvim

### glow.nvim

### neoscroll.nvim

### lsp-rooter

### todo-comments.nvim

### symbols-outline.nvim

### trouble.nvim

### vim-sanegx

### vim-cursorword

### vim-surround

### vim-repeat

### codi.vim

### compe-tabnine

