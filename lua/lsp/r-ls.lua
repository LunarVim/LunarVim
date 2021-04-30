require'lspconfig'.r_language_server.setup{
	cmd = { "R", "--slave", "-e", "languageserver::run()" },
    filetypes = { "r", "rmd" },
    log_level = 2,
    -- root_dir = root_pattern(".git") or os_homedir
}
