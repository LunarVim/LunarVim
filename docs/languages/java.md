# Java

## Install Syntax Highlighting

```vim
:TSInstall java
```

## Supported language servers

```lua
java = { "jdtls" }
```

NOTE: jdtls requires jdk-11 or newer to run.

## Supported formatters

```lua
java = { "clang-format", "uncrustify" }
```

## LSP Settings

```lua
:LspSettings jdtls
```
This will generate the `jdtls.json` file where you can change the settings, the example document has this structure, but is too large to put it all here
```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "description": "This is onyl an example, the full document has mora than 700 lines",
  "properties": {
    "java.autobuild.enabled": {
      "default": true,
      "description": "Go to the original document, this is just an example",
      "scope": "window",
      "type": "boolean"
    },
    "java.codeGeneration.generateComments": {
      "default": false,
      "description": "Go to the original document, this is just an example",
      "scope": "window",
      "type": "boolean"
    },
 }
```
You can find the full document at nlsp-settings [generated schema](https://github.com/tamago324/nlsp-settings.nvim/blob/main/schemas/_generated/jdtls.json)

## Debugger

(TODO)
