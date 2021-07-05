-- Example configuations here: https://github.com/mattn/efm-langserver
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
local M = {}

M.setup = function()
    local tsserver_args = {}

    local prettier = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true
    }

    local eslint = {
        lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"},
    }

    if vim.fn.glob("node_modules/.bin/prettier") then
        prettier = {
            formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
            formatStdin = true
        }
    end

    require"lspconfig".efm.setup {
        -- init_options = {initializationOptions},
        cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
        init_options = {documentFormatting = true, codeAction = true},
        filetypes = {"html", "json", "css", "yaml", "javascript"},
        settings = {
            rootMarkers = {".git/", "package.json"},
            languages = {
                html = {prettier},
                json = {prettier, eslint},
                css = {prettier, eslint},
                yaml = {prettier},
                javascript = {prettier, eslint}
                -- markdown = {markdownPandocFormat, markdownlint},
            }
        }
    }
end

return M
