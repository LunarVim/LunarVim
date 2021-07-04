local python_arguments = {}

-- TODO replace with path argument
local flake8 = {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local isort = {formatCommand = "isort --quiet -", formatStdin = true}

local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
local black = {formatCommand = "black --quiet -", formatStdin = true}

if O.lang.python.linter == 'flake8' then table.insert(python_arguments, flake8) end

if O.lang.python.isort then table.insert(python_arguments, isort) end

if O.lang.python.formatter == 'yapf' then
    table.insert(python_arguments, yapf)
elseif O.lang.python.formatter == 'black' then
    table.insert(python_arguments, black)
end

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"python"},
    settings = {
        rootMarkers = {".git/", "requirements.txt"},
        languages = {
            python = python_arguments,
        }
    }
}













-- npm i -g pyright
require'lspconfig'.pyright.setup {
    cmd = {
        DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
        "--stdio"
    },
    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic
                                                               .on_publish_diagnostics,
                                                           {
            virtual_text = O.lang.python.diagnostics.virtual_text,
            signs = O.lang.python.diagnostics.signs,
            underline = O.lang.python.diagnostics.underline,
            update_in_insert = true
        })
    },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = O.lang.python.analysis.type_checking,
                autoSearchPaths = O.lang.python.analysis.auto_search_paths,
                useLibraryCodeForTypes = O.lang.python.analysis
                    .use_library_code_types
            }
        }
    }
}
if O.lang.python.autoformat then
    require('lv-utils').define_augroups({
        _python_autoformat = {
            {
                'BufWritePre', '*.py',
                'lua vim.lsp.buf.formatting_sync(nil, 1000)'
            }
        }
    })
end
