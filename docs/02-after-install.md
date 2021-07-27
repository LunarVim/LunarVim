# Quick start

After installing you should be able to start LunarVim with the `lvim` command

**NOTE:** `<TAB>` indicates that you should press the `<TAB>` key and cycle through your options 

To install syntax highlighting and tressitter support for your language:

```vim
:TSInstall <TAB>
```

To install a Language Server for your language:

```vim
:LspInstall <TAB>
```

To create a configuration file for your language server:

```vim
:NlspSettings <TAB>
```

**NOTE:** This will create a directory in `~/.config/lvim/lsp-settings` where you will be able to configure your language server, make sure to install `jsonls` for autocompletion.
