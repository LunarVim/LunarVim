# Java

## Install Syntax Highlighting

```vim
:TSInstall java
```

## Supported language servers

```lua
{ "jdtls" }
```

jdtls is installed automatically once you open a `.java` file.

:::note

jdtls requires **jdk-17 or newer** to run.

:::

## Supported formatters

```lua
{ "astyle", "clang_format", "google_java_format", "npm_groovy_lint", "uncrustify" }
```

The Java language server (jdtls) also supports formatting, and it is enabled by default. It is possible to fine-tune its formatting rules, but it is also possible to use a different formatter from the above list. When such a formatter is used, jdtls formatting will be disabled to avoid conflict.

### jdtls

Neovim (by default) passes basic options (such as `vim.opt.shiftwidth` and `vim.opt.tabstop`) to the language server when formatting.

It is possible to further customize jdtls formatting by supplying an Eclipse formatter file.

To do so, type `:LspSettings jdtls`. It will create a JSON file at `.config/lvim/lsp-settings/jdtls.json` and can be treated as global settings.

Add the following content:

```json
{
  "java.format.settings.profile": "GoogleStyle",
  "java.format.settings.url": "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
}
```
To reference a local file in the url attribute, simply set its path: `"java.format.settings.url": ".config/lvim/custom-formatter.xml"`

It is also possible to specify project-specific configs. To do so, type `:LspSettings local jdtls` which will create `.nlsp-settings/jdtls.json` in the current working directory, and paste the config that we used for the global settings.

More information about Lsp commands can be found at https://github.com/tamago324/nlsp-settings.nvim

### Custom formatters

Custom formatters are CLI tools that are wrapped with null-ls plugin, which is available by default in LunarVim. They should be installed separately from LunarVim and be available on $PATH.

#### clang-format

clang-format is traditionally used for formatting C/C++ code but can also be used for Java code formatting.

Prerequisites:
clang-format should be on the $PATH

Enable formatter in `~/.config/lvim/config.lua`:
```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "clang-format",
    filetypes = { "java" },
  }
}
```
With the above configuration, the default settings will be used. To see the defaults, type `clang-format --dump-config` in the terminal.

clang-format suppors multiple predefined styles. For the list of values see: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#configurable-format-style-options

To specify such style you need to set extra args in `config.lua`:
```lua
  {
    command = "clang-format",
    filetypes = { "java" },
    extra_args = { "--style", "Google" },
  }
```

It is also possible to use a format file. For that, you will need a valid clang-format file. You can create one from an existing style that can be used as a base: `clang-format --style=Google --dump-config > .clang-format`

`config.lua`:
```lua
  {
    command = "clang-format",
    filetypes = { "java" },
    extra_args = { "--style", "file:<format_file_path>" },
  }
```

#### google-java-format

google-java-format is a program that reformats Java source code to comply with Google Java Style.

Prerequisites:
google-java-format should be on the $PATH

Enable formatter in `~/.config/lvim/config.lua`:
```lua
atters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "google-java-format",
    filetypes = { "java" },
  }
}
```

#### uncrustify

uncrustify works similarly to clang-format.

Enable formatter in `~/.config/lvim/config.lua`:
```lua
atters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "uncrustify",
    filetypes = { "java" },
    extra_args = { "-c", "path/to/your.cfg" },
  }
}
```

## Supported linters

```lua
{ "checkstyle", "pmd", "semgrep" }
```

## Advanced configuration

It is also possible to fully customize the language server. See https://github.com/LunarVim/starter.lvim to get ideas on how to proceed with that.

