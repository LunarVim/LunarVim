# C# (csharp)

## Install Syntax Highlighting

```vim
:TSInstall c_sharp
```

## Install Language Server

```vim
:LspInstall csharp
```

## Formatters

The csharp language server OmniSharp supports formatting. Formatting is automatically enabled by installing the csharp language server. The formatting options can be changed by with the [OmniSharp configuration options](https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options).

[clang-format](https://www.electronjs.org/docs/development/clang-format) can optionally be used as a C# formatter. After installing the `clang-format` the formatter is enabled with configuration. OmniSharp formatter is then automatically disabled.
