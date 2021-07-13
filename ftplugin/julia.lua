local util = require("lspconfig/util")
-- The default config lazily evaluates the location of the julia language server from the your global julia packages.
-- This adds a small overhead on first opening of a julia file. To avoid this overhead, replace server_path in on_new_config with
-- a hard-coded path to the server.

-- LanguageServer.jl can be installed with julia and Pkg
-- julia -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer")'

-- for details see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/julials.lua
local julials = "using LanguageServer  \n"
	.. "using LanguageServer.SymbolServer  \n"
	.. "let env = Base.load_path(),  \n"
	.. "dir = pwd(),  \n"
	.. 'depot_path = get(ENV, "JULIA_DEPOT_PATH", ""),  \n'
	.. "project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))  \n"
	.. "@info env dir project_path depot_path  \n"
	.. "server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)  \n"
	.. "server.runlinter = true  \n"
	.. "run(server)  \n"
	.. "end"

local cmd = {
	"julia",
	"--startup-file=no",
	"--history-file=no",
	"--e",
	julials,
}

require("lspconfig").julials.setup({
	cmd = cmd,
	on_new_config = function(new_config, _)
		local server_path = vim.fn.system(
			"julia --startup-file=no -q -e 'print(dirname(dirname(Base.find_package(\"LanguageServer\"))))'"
		)
		local new_cmd = vim.deepcopy(cmd)
		table.insert(new_cmd, 2, "--project=" .. server_path)
		new_config.cmd = new_cmd
	end,
	filetypes = { "julia" },
	root_dir = function(fname)
		return util.find_git_ancestor(fname) or vim.fn.getcwd()
	end,
})
