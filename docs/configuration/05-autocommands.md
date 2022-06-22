# Autocommands

To set up autocommands use the native nvim api `vim.api.nvim_create_autocmd`, or use the helper Lunarvim table `lvim.autocmds` which will be passed to [define_autocmds()](https://github.com/LunarVim/lunarvim/blob/3475f7675d8928b49c85878dfc2912407de57342/lua/lvim/core/autocmds.lua#L177) automatically.
```lua
lvim.autocmds = {
    "BufEnter", -- see `:h autocmd-events`
      { -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
          pattern = { "*.json", "*.jsonc" }, -- see `:h autocmd-events`
          command = "setlocal wrap", 
      }
    },
```
This will run a command at a given event for the given filetype.

An example using the nvim api could look like this:
```lua
vim.api.nvim_create_autocmd("BufEnter", {
	  pattern = { "*.json", "*.jsonc" },
	  -- enable wrap mode for json files only
	  command = "setlocal wrap",
})
```
You can also add lua callbacks

```lua
lvim.autocommands = {
    {
      "BufWinEnter", {
      pattern = { "*.cpp", "*.hpp" },
      callback = function()
        -- DYI editorconfig
        if vim.loop.cwd() == "path/to/my/project" then
          vim.cmd [[setlocal tabstop=8 shiftwidth=8]]
        end
      end
    },
  }
}
```
