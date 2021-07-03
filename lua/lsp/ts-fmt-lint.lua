-- Example configuations here: https://github.com/mattn/efm-langserver
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
local M = {}

M.setup = function()
    local tsserver_args = {}

    local prettier = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true
    }

    if vim.fn.glob("node_modules/.bin/prettier") then
        prettier = {
            formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
            formatStdin = true
        }
    end

    -- TODO global eslint?

    local eslint = {
        lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"},
        -- formatCommand = "./node_modules/.bin/eslint -f unix --fix --stdin-filename ${INPUT}", -- TODO check if eslint is the formatter then add this
        formatStdin = true
    }

    if O.lang.tsserver.formatter == 'prettier' then
        table.insert(tsserver_args, prettier)
    end

    if O.lang.tsserver.linter == 'eslint' then
        table.insert(tsserver_args, eslint)
    end

    require"lspconfig".efm.setup {
        -- init_options = {initializationOptions},
        cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
        init_options = {documentFormatting = true, codeAction = false},
        filetypes = {
            "javascriptreact", "javascript", "typescript", "typescriptreact",
            "html", "css", "yaml", "vue"
        },
        settings = {
            rootMarkers = {".git/", "package.json"},
            languages = {
                javascript = tsserver_args,
                javascriptreact = tsserver_args,
                typescript = tsserver_args,
                typescriptreact = tsserver_args,
                html = {prettier},
                css = {prettier},
                json = {prettier},
                yaml = {prettier}
                -- javascriptreact = {prettier, eslint},
                -- javascript = {prettier, eslint},
                -- markdown = {markdownPandocFormat, markdownlint},
            }
        }
    }
end

return M
