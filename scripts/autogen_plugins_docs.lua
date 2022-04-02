local M = {}

local utils = require("lvim.utils")

function M.generate_core_plugins_list()
	local output = "scripts/core_plugins"
	local info_table = {}

	local core_plugins = require("lvim.plugins")
	local Job = require("plenary.job")
	local jobs = {}

	local header = [[# Core Plugins]]
	local columns = [[|name|description|status|]]
	local sep = [[|-|-|-|]]

	local lines = {
		header,
		"",
		columns,
		sep,
	}

	for _, plugin in pairs(core_plugins) do
		local repo = plugin[1]
		local job = Job:new({ command = "gh", args = { "api", "/repos/" .. repo, "-q", ".description" } })
		job:after_success(function(this_job)
			local description = this_job:result()[1]
			local entry = {
				name = string.format("<a href='https://github.com/%s'>%s</a>", repo, repo),
				description = description,
				enabled = not plugin.disable,
			}
			info_table[#info_table + 1] = entry
		end)

		job:start()
		table.insert(jobs, job)
	end
	Job.join(unpack(jobs))

	local default_first = function(first, second)
		return first.enabled and not second.enabled
	end
	table.sort(info_table, default_first)

	local md_info = vim.tbl_map(function(entry)
		return string.format([[|%s|%s|%s|]], entry.name, entry.description, entry.enabled and "" or "optional")
	end, info_table)

	vim.list_extend(lines, md_info)
	utils.write_file(output .. ".json", vim.json.encode(info_table):gsub("\\", ""), "w")
	utils.write_file(output .. ".md", table.concat(lines, "\n"), "w")
end

M.generate_core_plugins_list()

return M
