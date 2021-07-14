-- The default config lazily evaluates the location of the julia language server from the your global julia packages.
-- This adds a small overhead on first opening of a julia file. To avoid this overhead, replace server_path in on_new_config with
-- a hard-coded path to the server.

-- LanguageServer.jl can be installed with julia and Pkg
-- julia -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer")'

-- for details see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/julials.lua
local cmd = {
	"julia",
	"--startup-file=no",
	"--history-file=no",
	CONFIG_PATH .. "/lua/lsp/julia/run.jl",
}

require("lspconfig").julials.setup({
	cmd = cmd,
	on_new_config = function(new_config, _)
		new_config.cmd = cmd
	end,
	filetypes = { "julia" },
})
