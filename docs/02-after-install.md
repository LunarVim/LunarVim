# Quick start

After installing you should be able to start LunarVim with the `lvim` command

**NOTE:** `<TAB>` indicates that you should press the `<TAB>` key and cycle through your options 

## Tree-sitter
To install syntax highlighting and treesitter support for your language:

```vim
:TSInstall <TAB>
```

Not all languages are supported.  For a list of supported languages [look here](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

## Language Server
To install a Language Server for your language:

```vim
:LspInstall <TAB>
```

Sometimes the language server for your language will not have an obvious name.  For instance, the language server for ruby is solargraph.  Metals is the language server for scala, etc.  To find the corresponding language server for your language [look here](https://github.com/kabouzeid/nvim-lspinstall)

## Language Server Configuration
To create a configuration file for your language server:

```vim
:NlspConfig <TAB>
:NlspConfig <NAME_OF_LANGUAGE_SERVER> 
```

**NOTE:** This will create a directory in `~/.config/lvim/lsp-settings` where you will be able to configure your language server.

Make sure to install `jsonls` for autocompletion.  Not all language servers are supported.  For a list of supported language servers [look here](https://github.com/tamago324/nlsp-settings.nvim/blob/main/schemas/README.md)


## Nerd Fonts
Installing a [nerd font](https://www.nerdfonts.com/) is recommended. Otherwise some symbols won't be rendered properly. For more information go to the [configuration section ](./configuration/04-nerd-fonts.md). 

