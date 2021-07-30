# Migrating from an old version of LunarVim
If you were previously using LunarVim from before July 20th, 2021, you'll notice that many things changed.  

* If you were on a version of LunarVim prior to commit d022651, you will need to [remove it completely](https://github.com/ChristianChiarulli/LunarVim/wiki/Uninstalling-LunarVim) before upgrading
* Going forward LunarVim will no longer reside in the nvim configuration folder.  LunarVim has been moved to `~/.local/share/lunarvim`.  
* To launch Lunarvim use the new `lvim` command.  `nvim` will only launch standard neovim.  
* Your personal configuration file (`lv-config.lua`) can now be found in `~/.config/lvim`.  You can initialize this folder as a git repository to track changes to your configuration files.
* If you want to keep launching LunarVim with the `nvim` command, add an alias entry to your shell's config file:  `alias nvim=lvim`.  To temporarily revert to the default `nvim` prefix it with a backslash `\nvim`.

## Options in `lv-config.lua` have been renamed
| Old Option | New Option |
| -------- | :----------: |
| O | lvim |
| O.plugin | lvim.builtin |
| O.treesitter | lvim.builtin.treesitter |
| O.keys.leader_key | lvim.leader |
| O.user_plugins | lvim.plugins |
| O.user_which_key | lvim.builtin.which_key |
| O.user_autocommands | lvim.autocommands |
| O.lang | lvim.lang |
| (Did not previously exist) | lvim.lsp.override |
| O.default_options.\<option\>  | (removed)  Now set options with the form `vim.cmd("set relativenumber")`|  
| O.default_options.on_attach_callback | lvim.lsp.on_attach_callback |
| O.disabled_built_ins | (removed) |
| O.formatters.filetype | lvim.lang.c.formatter.exe |
| O.completion.autocomplete | lvim.builtin.compe.autocomplete|

