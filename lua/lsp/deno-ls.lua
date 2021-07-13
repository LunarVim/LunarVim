print(require("lv-utils"))
if require("lv-utils").check_lsp_client_active("denols") then
	return
end

-- :LspInstall deno
print(require("lspconfig"))
require("lspconfig").denols.setup({
	cmd = { DATA_PATH .. "/lspinstall/deno/bin/deno", "lsp" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },

	init_options = {
		enable = true,
		lint = true,
		unstable = true,
	},
	root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
})
