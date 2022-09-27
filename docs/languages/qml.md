# QML

## Install Syntax Highlighting

There is no official Treesitter support for QML, so instead you could use [the
plugin](https://github.com/peterhoeg/vim-qml):

```lua
{
  "peterhoeg/vim-qml",
  event = "BufRead",
  ft = { "qml" },
},
```

## Supported language servers

Currently QML does not have an official LSP, but its development is currently
[in progress](https://bugreports.qt.io/browse/QTBUG-68406).

## Supported formatters

```lua
qml = { "qmlformat" }
```

## Supported linters

```lua
qml = { "qmllint" }
```

## See also

- [C/C++ Configuration](c_cpp.md)
