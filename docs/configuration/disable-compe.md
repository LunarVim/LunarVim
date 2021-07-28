# Disable tab completion
When writing code pressing `TAB` triggers autocomplete.  But in simple text files hitting tab should insert a `TAB` character.   LunarVim turns off tab autocompletion for markdown and txt files.  To disable autocompletion for other filetypes modify `lvim.builtin.compe.exclude_filetypes` in your `lv-config.lua`.

```
lvim.builtin.compe.exclude_filetypes = { "md", "markdown", "mdown", "mkd", "mkdn", "mdwn", "text", "txt" },
```

`Control`+`space` will still trigger completion. This is useful for autocompleting emoji in text files. (type `:` and hit `control`+`space` or `TAB` to cycle through emoji)

