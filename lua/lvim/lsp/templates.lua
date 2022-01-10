local M = {}

local Log = require "lvim.core.log"
local utils = require "lvim.utils"
local lvim_lsp_utils = require "lvim.lsp.utils"

local ftplugin_dir = lvim.lsp.templates_dir

local join_paths = _G.join_paths

function M.remove_template_files()
  -- remove any outdated files
  for _, file in ipairs(vim.fn.glob(ftplugin_dir .. "/*.lua", 1, 1)) do
    vim.fn.delete(file)
  end
end

---Generates an ftplugin file based on the server_name in the selected directory
---@param server_name string name of a valid language server, e.g. pyright, gopls, tsserver, etc.
---@param dir string the full path to the desired directory
function M.generate_ftplugin(server_name, dir)
  if vim.tbl_contains(lvim.lsp.override, server_name) then
    return
  end

  -- we need to go through lspconfig to get the corresponding filetypes currently
  local filetypes = lvim_lsp_utils.get_supported_filetypes(server_name) or {}
  if not filetypes then
    return
  end

  for _, filetype in ipairs(filetypes) do
    local filename = join_paths(dir, filetype .. ".lua")
    local setup_cmd = string.format([[require("lvim.lsp.manager").setup(%q)]], server_name)
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

  Log:debug "Templates installation in progress"

  M.remove_template_files()

  if vim.tbl_isempty(servers_names) then
    local available_servers = require("nvim-lsp-installer.servers").get_available_servers()

    for _, server in pairs(available_servers) do
      table.insert(servers_names, server.name)
      table.sort(servers_names)
    end
  end

  -- create the directory if it didn't exist
  if not utils.is_directory(lvim.lsp.templates_dir) then
    vim.fn.mkdir(ftplugin_dir, "p")
  end

  for _, server in ipairs(servers_names) do
    M.generate_ftplugin(server, ftplugin_dir)
  end
  Log:debug "Templates installation is complete"
end

return M
