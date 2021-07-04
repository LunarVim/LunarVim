-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local sumneko_root_path = DATA_PATH .. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = require'lsp'.common_on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                },
                maxPreload = 100000,
                preloadFileSize = 1000
            }
        }
    }
}
if O.lang.lua.autoformat then
    require('lv-utils').define_augroups({
        _lua_autoformat = {
            {
                'BufWritePre', '*.lua',
                'lua vim.lsp.buf.formatting_sync(nil, 1000)'
            }
        }
    })
end

local lua_arguments = {}

local luaFormat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=80",
    formatStdin = true
}

local lua_fmt = {
    formatCommand = "luafmt --indent-count 2 --line-width 120 --stdin",
    formatStdin = true
}

if O.lang.lua.formatter == 'lua-format' then
  table.insert(lua_arguments, luaFormat)
elseif O.lang.lua.formatter == 'lua-fmt' then
  table.insert(lua_arguments, lua_fmt)
end

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = lua_arguments,
        }
    }
}
