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

## TODO : lua version
