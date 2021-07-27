# Installing Plugins

You can easily install plugins using the options provided by packer.

Just add your plugin to the `lvim.plugins` table in your `lv-config.lua` file and save the file (don't quit or the operation will not run).

## Example

```lua
lvim.plugins = {
    {"lunarvim/colorschemes"},
    {"folke/tokyonight.nvim"}, 
    {
        "ray-x/lsp_signature.nvim",
        config = function() 
          require"lsp_signature".on_attach() 
        end,
        event = "InsertEnter"
    },
}
```

After adding the following to your `lv-config.lua` just `:w` and the plugins will automatically install.

## Plugin Quickstart

Just paste any of these snippets into `lvim.plugins`, save (`:w`), and it will autoinstall.

## Navigation

### hop

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

## General

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
