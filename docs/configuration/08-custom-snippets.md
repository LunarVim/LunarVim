---
sidebar_position: 8
---

# Custom snippets

## Description

You can add your own snippets to LunarVim.

Custom snippets can be defined as json or lua.

### json version

First create a folder : `~/.config/lvim/snippets/` next to your `config.lua`

Then in there you need at least 2 files.

The first file describes where your snippets are :

`package.json` :

```json
{
    "name": "nvim-snippets",
    "author": "authorname",
    "engines": {
        "vscode": "^1.11.0"
    },
    "contributes": {
        "snippets": [
            {
                "language": "python",
                "path": "./python.json"
            }
        ]
    }
}
```

For each language, create a file like this :

`python.json` :

```json
{
  "hello": {
    "prefix": "hello",
    "body": [
      "print('Hello, World!')"
    ],
    "description": "print Hello, World!"
  }
}
```

You should be able to expand `hello` into `print("Hello, World!")`

### lua version

First create a folder named `luasnippets` next to your `config.lua`. For example `~/.config/lvim/luasnippets/`

Then, inside that folder, create a lua file named with the filetype you want to create snippets for. For example, for creating snippets for lua, create a (redundant, but correct) file named `lua.lua`. Then you put your files there like this:

```lua
return {
  s("foo", { t "Expands to bar" }),
}
```
LuaSnip is able to hot-reload snippets defined in lua when you save them, but you may need to restart LunarVim the first time you create the snippet files.
Please note that LuaSnip injects a bunch of utility globals when it loads your snippets (in this example the `s` and `t` functions), so you don't need to care about requiring or defining them. To get more detailed information and examples please read the [LuaSnip docs about this topic](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua)

### TODO: snipmate version
