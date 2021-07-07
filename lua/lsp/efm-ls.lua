local efm = {}

function efm.generic_setup(ft)
	require("lspconfig").efm.setup({
		cmd = {
			DATA_PATH .. "/lspinstall/efm/efm-langserver",
			"-c",
			O.efm.config_path,
		},
		init_options = { documentFormatting = true, codeAction = false, completion = false, documentSymbol = false },
		filetypes = ft,
    -- rootMarkers = {".git/", "package.json"},
	})
end

return efm
