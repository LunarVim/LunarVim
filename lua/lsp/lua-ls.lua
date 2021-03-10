-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- TODO fix for different systems and put variable for user

user="chris"

local sumneko_root_path = ""
local sumneko_binary = ""

local system_name
if vim.fn.has("mac") == 1 then
  sumneko_root_path = "/Users/"..user.."/.config/nvim/lua-language-server"
  sumneko_binary = "/Users/"..user.."/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  sumneko_root_path = "/home/"..user.."/.config/nvim/lua-language-server"
  sumneko_binary = "/home/"..user.."/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
elseif vim.fn.has('win32') == 1 then
  -- sumneko_root_path = "/Users/chris/.config/nvim/lua-language-server"
  -- sumneko_binary = "/Users/chris/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
  print("Unsupported system for me")
else
  print("Unsupported system for sumneko")
end

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
