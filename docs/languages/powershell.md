# PowerShell

## Install Syntax Highlighting

Currently there is no maintained PowerShell parser available. If needed, configure a unmaintained parser by adding the following code to e.g. `config.lua`

```lua
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.powershell = {
  install_info = {
    url = "https://github.com/jrsconfitto/tree-sitter-powershell",
    files = {"src/parser.c"}
  },
  filetype = "ps1",
  used_by = { "psm1", "psd1", "pssc", "psxml", "cdxml" }
}
```

Install the configured parser.

```lua
:TSInstall powershell
```

## Supported language servers

```lua
ps1 = { "powershell_es" },
```

For more information about the language server configuration, refer to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#powershell_es)

## Formatters

Formatting is supported by the PowerShell ES language server without additional configuration.
