local lv_utils = {}

LocalConfigTrusted = false

function lv_utils.ask_user(prompt, cb)
  local answer = vim.fn.input(prompt)

  -- Clear all the output in the status line so that it looks good!
  print ""

  if answer ~= "" and string.lower(string.sub(answer, 1, 1)) == "y" then
    if cb then
      cb()
    end
    return true
  end

  return false
end

function lv_utils.check_if_config_trusted(config_file)
  local trusted_local_configs_file = DATA_PATH .. "/lunar_vim/trusted_local_configs"
  if vim.fn.filereadable(trusted_local_configs_file) ~= 1 then
    local file = io.open(trusted_local_configs_file, "w")
    file:close()
  end

  local file, err = io.open(trusted_local_configs_file, "r")
  if err then
    return false
  end
  local content = file:read()

  if content and content:find(config_file, nil, true) then
    LocalConfigTrusted = true
    file:close()
    return true
  end

  file:close()
  return false
end

function lv_utils.make_config_trusted(config_file)
  local file = io.open(DATA_PATH .. "/lunar_vim/trusted_local_configs", "a")

  LocalConfigTrusted = true
  file:write(config_file, "\n")

  file:close()
end

function lv_utils.load_user_config()
  -- Load the user config
  local global_status_ok, _ = pcall(vim.cmd, "luafile " .. CONFIG_PATH .. "/lv-config.lua")
  if not global_status_ok then
    print "something is wrong with your lv-config"
  end

  -- Check if a local config exists and source it
  local local_config_path = vim.fn.getcwd() .. "/.lv-config.lua"
  if vim.fn.filereadable(local_config_path) == 1 then
    if
      O.never_trust_local_config
      or not (
        O.always_trust_local_config
        or LocalConfigTrusted
        or lv_utils.check_if_config_trusted(local_config_path)
        or lv_utils.ask_user(
          [[There is a local `lv-config` file in this directory!
Do you trust this file? Note such files could be insecure! (y/N)]],
          function()
            lv_utils.make_config_trusted(local_config_path)
          end
        )
      )
    then
      return
    end

    local local_status_ok, _ = pcall(vim.cmd, "luafile " .. local_config_path)
    if not local_status_ok then
      print "something is wrong with your local lv-config (./.lv-config.lua)"
    end
  end
end

function lv_utils.reload_lv_config()
  lv_utils.load_user_config()
  vim.cmd "source ~/.config/nvim/lua/plugins.lua"
  vim.cmd "source ~/.config/nvim/lua/settings.lua"
  vim.cmd "source ~/.config/nvim/lua/lv-formatter/init.lua"
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
end

function lv_utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function lv_utils.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

lv_utils.define_augroups {

  _user_autocommands = O.user_autocommands,
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufRead",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufNewFile",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    { "BufWritePost", "lv-config.lua,.lv-config.lua", "lua require('lv-utils').reload_lv_config()" },
    -- { "VimLeavePre", "*", "set title set titleold=" },
  },
  _solidity = {
    { "BufWinEnter", ".tf", "setlocal filetype=hcl" },
    { "BufRead", "*.tf", "setlocal filetype=hcl" },
    { "BufNewFile", "*.tf", "setlocal filetype=hcl" },
  },
  -- _solidity = {
  --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
  --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
  -- },
  -- _gemini = {
  --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
  --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
  -- },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _buffer_bindings = {
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    { "VimResized", "*", "wincmd =" },
  },
  _packer_compile = {
    -- will cause split windows to be resized evenly if main window is resized
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },
  -- _fterm_lazygit = {
  --   -- will cause esc key to exit lazy git
  --   {"TermEnter", "*", "call LazyGitNativation()"}
  -- },
  -- _mode_switching = {
  --   -- will switch between absolute and relative line numbers depending on mode
  --   {'InsertEnter', '*', 'if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif'},
  --   {'InsertEnter', '*', 'if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif'},
  -- },
}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
endfunction
]]

return lv_utils

-- TODO: find a new home for these autocommands
