# Quick start

**NOTE:** `<TAB>` indicates that you should press the `<TAB>` key and cycle through your options. Press `<ENTER>` to select. 

## Startup and plugins

After installing, you should be able to start LunarVim with the `lvim` command.

Next, run the following commands to set up plugins:

```vim
:PackerInstall
:PackerSync
```

## Tree-sitter

To install syntax highlighting and tree-sitter support for your language:

```vim
:TSInstall <TAB>
```

Not all languages are supported. For a list of supported languages, see [here](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages).

## Language Server

To install a Language Server for your language:

```vim
:LspInstall <TAB>
```

The language server for your language will not always have an obvious name. For instance, the server for `ruby` is called `solargraph`. To find the corresponding language server for your language, see [here](https://github.com/kabouzeid/nvim-lspinstall).

## Language Server Configuration

To create a configuration file for your language server:

```vim
:NlspConfig <TAB>
:NlspConfig <NAME_OF_LANGUAGE_SERVER> 
```

**NOTE:** This will create a directory in `~/.config/lvim/lsp-settings` where you will be able to configure your language server.

Make sure to install `jsonls` for autocompletion.  Not all language servers are supported.  For a list of supported language servers, see [here](https://github.com/tamago324/nlsp-settings.nvim/blob/main/schemas/README.md).

## Nerd Fonts

Installing a [nerd font](https://www.nerdfonts.com/) is recommended to ensure that symbols are rendered properly. For more information, see our configuration page [here](./configuration/04-nerd-fonts.html). 

