require'lspconfig'.denols.setup{
    cmd = {DATA_PATH .. "/lspinstall/deno/bin/deno", "lsp"},
    init_options = {
      enable = true,
      lint = true,
      unstable = true
    }
}

