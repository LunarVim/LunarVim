To get scala LSP support working in Lunarvim, first you need to do the prerequisites listed here https://github.com/scalameta/nvim-metals#prerequisites.

Then use coursier to install the metals language server so that it is available on your PATH:

`cs install metals`

## Configure Lunarvim

Add the following to your `config.lua`

```
lvim.lang.scala.linters = {}

lvim.plugins = {
	{
		"scalameta/nvim-metals",
		config = function()
			require("metals").initialize_or_attach({})
		end,
	},
}
```
