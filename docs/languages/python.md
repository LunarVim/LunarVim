# Python

## Install Syntax Highlighting

```vim
:TSInstall python
```

## Install Language Server

```vim
:LspInstall python
```

## Formatters

```lua
lvim.lang.python.formatters = {
  {
    exe = "black", -- can be yapf, or isort as well
    args = {},
  },
}
```

## Linters

``` lua
lvim.lang.python.linters = {
  {
    exe = "flake8",
    args = {}, 
  },
}
```

## LSP Settings

```
:NlspConfig pyright
```

## Debugger
