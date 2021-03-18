-- Example configuations here: https://github.com/mattn/efm-langserver
require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua", "python"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=100",
                    formatStdin = true
                }
            },
            python = {
                {
                    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"},
                    formatCommand = "yapf --quiet",
                    formatStdin = true
                }
            }
        }
    }
}

-- TODO turn these eslint and prettier examples into something good
-- TODO also shellcheck and shell formatting
-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim
-- {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintIgnoreExitCode = true,
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
-- }


-- local eslint = {
--   lintCommand = './node_modules/.bin/eslint -f compact --stdin',
--   lintStdin = true,
--   lintFormats = {'%f: line %l, col %c, %trror - %m', '%f: line %l, col %c, %tarning - %m'},
--   lintIgnoreExitCode = true,
--   formatCommand = './node_modules/.bin/prettier-eslint --stdin --single-quote --print-width 120',
--   formatStdin = true,
-- }
--
-- nvim_lsp.efm.setup({
--     init_options = { documentFormatting = true },
--     root_dir = nvim_lsp.util.root_pattern('.git/'),
--     filetypes = {'javascript', 'javascriptreact'},
--     settings = {
--       rootMarkers = {'.git/'},
--       languages = {
--         javascript = {eslint},
--         javascriptreact = {eslint},
--       }
--     }
-- })
