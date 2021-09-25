local M = {}
local configs = require "lspconfig/configs"
local uv = vim.loop

local utils = {}

function utils.join_paths(...)
  local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat(vim.tbl_flatten { ... }, path_sep):gsub(path_sep .. "+", path_sep)
  return result
end

local generated_dir = os.getenv "FT_GEN_DIR"
  or utils.join_paths(os.getenv "LUNARVIM_RUNTIME_DIR", "site", "after", "ftplugin")

-- create the directory if it didn't exist
vim.fn.mkdir(generated_dir, "p")

-- remove any outdated files
for _, file in ipairs(vim.fn.glob(generated_dir .. "/*.lua", 1, 1)) do
  vim.fn.delete(file)
end

function utils.write_file(path, txt, flag)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, txt, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

local function get_supported_filetypes(server_name)
  -- print("got filetypes query request for: " .. server_name)
  pcall(require, ("lspconfig/" .. server_name))

  for _, config in pairs(configs) do
    if config.name == server_name then
      return config.document_config.default_config.filetypes or {}
    end
  end
end

---Generates an ftplugin file based on the server_name in the selected directory
---@param server_name string name of a valid language server, e.g. pyright, gopls, tsserver, etc.
---@param dir string the full path to the desired directory
function M.generate_ftplugin(server_name, dir)
  -- we need to go through lspconfig to get the corresponding filetypes currently
  local filetypes = get_supported_filetypes(server_name) or {}
  if not filetypes then
    return
  end

  -- print("got associated filetypes: " .. vim.inspect(filetypes))

  for _, filetype in ipairs(filetypes) do
    local filename = utils.join_paths(dir, filetype .. ".lua")
    local setup_cmd = string.format([[require("lsp.manager").ensure_configured(%q)]], server_name)
    -- print("using setup_cmd: " .. setup_cmd)
    -- overwrite the file completely
    utils.write_file(filename, setup_cmd .. "\n", "a")
  end
end

---Generates ftplugin files based on a list of server_names
---The files are generated to a runtimepath: "$LUNARVIM_RUNTIME_DIR/site/after/ftplugin/template.lua"
---@param servers_names table list of servers to be enabled. Will add all by default
function M.generate_templates(servers_names)
  servers_names = servers_names or {}

  if vim.tbl_isempty(servers_names) then
    local available_servers = require("nvim-lsp-installer.servers").get_available_servers()

    for _, server in pairs(available_servers) do
      table.insert(servers_names, server.name)
    end
  end

  for _, server in ipairs(servers_names) do
    M.generate_ftplugin(server, generated_dir)
  end
end

return M
