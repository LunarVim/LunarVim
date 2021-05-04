local lsp = require'lspconfig'
lsp.gdscript.setup{
	root_dir = lsp.util.root_pattern(".git","project.godot")
}
