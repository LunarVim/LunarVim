local M = {}

local null_ls = require("null-ls")
local sources = {}

local local_executables = { "prettier", "prettierd", "prettier_d_slim", "eslint_d", "eslint" }

local function is_table(t)
	return type(t) == "table"
end

local function is_string(t)
	return type(t) == "string"
end

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local find_local_exe = function(exe)
	vim.cmd("let root_dir = FindRootDirectory()")
	local root_dir = vim.api.nvim_get_var("root_dir")
	local local_exe = root_dir .. "/node_modules/.bin/" .. exe
	return local_exe
end

local function setup_ls(exe, type)
	if has_value(local_executables, exe) then
		local smart_executable = null_ls.builtins[type][exe]
		local local_executable = find_local_exe(exe)
		if vim.fn.executable(local_executable) then
			smart_executable._opts.command = local_executable
		end
		table.insert(sources, smart_executable)
	else
		table.insert(sources, null_ls.builtins[type][exe])
	end
	null_ls.register({ sources = sources })
end

local function setup(filetype, type)
	if type == "diagnostics" then
		executables = lvim.lang[filetype].linters
	end
	if type == "formatting" then
		executables = lvim.lang[filetype].formatter.exe
	end

	if is_table(executables) then
		for _, exe in pairs(executables) do
			setup_ls(exe, type)
		end
	end
	if is_string(executables) then
		setup_ls(executables, type)
	end
end

function M.setup(filetype)
	setup(filetype, "formatting")
	setup(filetype, "diagnostics")
end

return M
