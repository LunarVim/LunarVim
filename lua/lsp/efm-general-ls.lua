-- Example configuations here: https://github.com/mattn/efm-langserver
-- TODO this file needs to be refactored eache lang should be it's own file
-- python
local python_arguments = {}

-- TODO replace with path argument
local flake8 = {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local isort = {formatCommand = "isort --quiet -", formatStdin = true}

local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
local black = {formatCommand = "black --quiet --stdin-filename ", formatStdin = true}

if O.python.linter == 'flake8' then table.insert(python_arguments, flake8) end

if O.python.isort then table.insert(python_arguments, isort) end

if O.python.formatter == 'yapf' then
    table.insert(python_arguments, yapf)
elseif O.python.formatter == 'black' then
    table.insert(python_arguments, black)
end

-- lua
local lua_arguments = {}
local luaFormat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
    formatStdin = true
}

if O.lua.formatter == 'lua-format' then table.insert(lua_arguments, luaFormat) end

-- sh
local sh_arguments = {}

local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}

local shellcheck = {
    LintCommand = 'shellcheck -f gcc -x',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
}

if O.sh.formatter == 'shfmt' then table.insert(sh_arguments, shfmt) end

if O.sh.linter == 'shellcheck' then table.insert(sh_arguments, shellcheck) end

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local tsserver_args = {}

if O.tsserver.formatter == 'prettier' then table.insert(tsserver_args, prettier) end

if O.tsserver.linter == 'eslint' then table.insert(tsserver_args, eslint) end

-- local markdownlint = {
--     -- TODO default to global lintrc
--     -- lintcommand = 'markdownlint -s -c ./markdownlintrc',
--     lintCommand = 'markdownlint -s',
--     lintStdin = true,
--     lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
-- }

local markdownPandocFormat = {formatCommand = 'pandoc -f markdown -t gfm -sp --tab-stop=2', formatStdin = true}

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"lua", "python", "javascriptreact", "javascript", "sh", "html", "css", "json", "yaml", "markdown"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = python_arguments,
            lua = lua_arguments,
            sh = sh_arguments,
            javascript = tsserver_args,
            javascriptreact = tsserver_args,
            html = {prettier},
            css = {prettier},
            json = {prettier},
            yaml = {prettier},
            markdown = {markdownPandocFormat}
            -- javascriptreact = {prettier, eslint},
            -- javascript = {prettier, eslint},
            -- markdown = {markdownPandocFormat, markdownlint},
        }
    }
}

-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim
