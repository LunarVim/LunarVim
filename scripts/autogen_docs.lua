local M = {}

local in_headless = #vim.api.nvim_list_uis() == 0
local servers_filetype_map = require("nvim-lsp-installer._generated.filetype_map")
local sources = require("null-ls.sources")
local supported_filetypes = vim.fn.sort(vim.tbl_keys(servers_filetype_map))

local min_supported_filetypes = {
	"go",
	"java",
	"javascript",
	"json",
	"julia",
	"lua",
	"powershell",
	"python",
	"ruby",
	"rust",
	"scala",
	"typescript",
	"vue",
}

local function generate_docs(file, data)
	file = file or vim.fn.expand("%")
	local writer = io.open(file, "a")
	writer:write(table.concat(data, "\n"))
	writer:close()
end

function M.get_lsp_info(ft)
	ft = ft or vim.fn.expand("%:t:r")
	local supported_servers = servers_filetype_map[ft] or {}
	if #supported_servers == 0 then
		return {}
	end

	local data = {
		"### Supported language servers",
		"",
		"```lua",
		vim.inspect(supported_servers),
		"```",
		"",
	}
	if not in_headless then
		vim.api.nvim_command("let @+ = '" .. data .. "'")
		vim.fn.execute("put")
	end
	return data
end

function M.get_formatters_info(ft)
	ft = ft or vim.fn.expand("%:t:r")
	local supported_formatters = sources.get_supported(ft, "formatting")
	if vim.tbl_isempty(supported_formatters) then
		return {}
	end
	local data = {
		"### Supported formatters",
		"",
		"```lua",
		vim.inspect(supported_formatters),
		"```",
		"",
	}
	if not in_headless then
		vim.api.nvim_command("let @+ = '" .. data .. "'")
		vim.fn.execute("put")
	end
	return data
end

function M.get_linters_info(ft)
	ft = ft or vim.fn.expand("%:t:r")
	local supported_linters = sources.get_supported(ft, "diagnostics")
	if vim.tbl_isempty(supported_linters) then
		return {}
	end
	local data = {
		"### Supported linters",
		"",
		"```lua",
		vim.inspect(supported_linters),
		"```",
		"",
	}
	if not in_headless then
		vim.api.nvim_command("let @+ = '" .. data .. "'")
		vim.fn.execute("put")
	end
	return data
end

function M.generate_doc_files(filetypes)
	for _, entry in ipairs(filetypes) do
		local file = "docs/languages/" .. entry .. ".md"
		generate_docs(file, M.get_lsp_info(entry))
		generate_docs(file, M.get_formatters_info(entry))
		generate_docs(file, M.get_linters_info(entry))
	end
end

function M.generate_doc_global_supported(filetypes)
	local file = "docs/languages/supported.md"
	for _, entry in ipairs(filetypes) do
		local info = { "## " .. entry, "" }
		local main = {}
		vim.list_extend(main, M.get_lsp_info(entry))
		vim.list_extend(main, M.get_formatters_info(entry))
		vim.list_extend(main, M.get_linters_info(entry))
		if #main > 0 then
			vim.list_extend(info, main)
			vim.list_extend(info, { "" })
			generate_docs(file, info)
		end
	end
end

function M.generate_supported_table(filetypes)
	filetypes = filetypes or min_supported_filetypes
	local utils = require("lvim.utils")

	local supported_languages_info = {}

	for _, ft in ipairs(filetypes) do
		table.insert(supported_languages_info, {
			filetype = ft,
			servers = servers_filetype_map[ft] or nil,
			linters = sources.get_supported(ft, "diagnostics"),
			formatters = sources.get_supported(ft, "formatting"),
		})
	end
	utils.write_file("supported.lua", "return " .. vim.inspect(supported_languages_info), "w")
	local info_json = vim.json.encode(supported_languages_info)

	utils.write_file("supported.json", info_json, "w")
end

M.generate_supported_table(supported_filetypes)
-- M.generate_docs_languages(supported_filetypes)
M.generate_doc_global_supported(supported_filetypes)

return M
