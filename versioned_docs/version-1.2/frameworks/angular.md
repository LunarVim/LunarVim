# Angular

## Better syntax highlighting

You may want to add this plugin to your config. It provides treesitter integration with the Angular framework.

```lua
{ "nvim-treesitter/nvim-treesitter-angular" }
```

## Install Language Server

```vim
:LspInstall angularls
```

## Configure LunarVim

The `angularls` server is overriden by default. So it needs to be [manually configured](./../languages/README.md#server-override).

### Setup

Add this to your `config.lua` file:

```lua
require("lvim.lsp.manager").setup("angularls")
```

For more info about the LSP such as default values [checkout this](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls).

:::note

For Angular projects with version lesser than 9 (pre Ivy) you should provide the LSP with the `--viewEngine` flag.

:::
