# Terraform

## Syntax highlighting


First, within LunarVim run the following:

```vim
:TSInstall hcl
```

To enable Syntax Highlighting for `.tf` files as well, just add this to your `config.lua`:
```lua
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.hcl = {
  filetype = "hcl", "terraform",
}
```

## Supported language servers

```lua
terraform = { "terraform", "terraformls"},
```

## Supported formatters

```lua
terraform = { "terraform"} }
```
