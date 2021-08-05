# Autocommands
To set up autocommands use `lvim.autocommands.custom_groups.  Autocommands are defined in the form `{Event, filetype, command }`.  This will run a command at a given event for the given filetype.

To view help on autocommands: `:h autocmd`

Here is a [list of events](https://tech.saigonist.com/b/code/list-all-vim-script-events.html)
``` lua
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
}
```
