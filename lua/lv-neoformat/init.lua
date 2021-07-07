-- autoformat
if O.format_on_save then
	require("lv-utils").define_augroups({
		autoformat = {
			{
				"BufWritePre",
				"*",
				[[try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]],
			},
		},
	})
end

if not O.format_on_save then
	vim.cmd([[if exists('#autoformat#BufWritePre')
	:autocmd! autoformat
	endif]])
end
