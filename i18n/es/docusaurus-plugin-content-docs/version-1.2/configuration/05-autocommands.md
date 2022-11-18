# Comandos Automaticos

Para añadir comandos automaticos puedes usar la api nativa de nvim `vim.api.nvim_create_autocmd` o también puedes usar la tabla que te brinda LunarVim para hacerlo `lvim.autocommands`, con ambas formas obtienes el mismo resultado, ya que LunarVim va a enviar estos comandos a la api de nvim por medio de [define_autocmds()](https://github.com/LunarVim/lunarvim/blob/3475f7675d8928b49c85878dfc2912407de57342/lua/lvim/core/autocmds.lua#L177) automáticamente.

```lua
lvim.autocommands = {
    "BufEnter", -- ver `:h autocmd-events`
      { -- esta tabla es enviada como `opts` a `nvim_create_autocmd`
          pattern = { "*.json", "*.jsonc" }, -- ver `:h autocmd-events`
          command = "setlocal wrap", 
      }
    },
```
Esto va a ejecutar un comando cuando se registre el evento que coincida con el tipo de archivo proporcionado.

Un ejemplo usando la api de nvim se veria de la siguiente forma:
```lua
vim.api.nvim_create_autocmd("BufEnter", {
	  pattern = { "*.json", "*.jsonc" },
	  -- habilita el modo wrap solo para archivos json
	  command = "setlocal wrap",
})
```
Tambíén puedes añadir callbacks con lua. 

```lua
lvim.autocommands = {
    {
      "BufWinEnter", {
      pattern = { "*.cpp", "*.hpp" },
      callback = function()
        -- mira ma!, estoy usando LunarVim
        if vim.loop.cwd() == "path/to/my/project" then
          vim.cmd [[setlocal tabstop=8 shiftwidth=8]]
        end
      end
    },
  }
}
```
