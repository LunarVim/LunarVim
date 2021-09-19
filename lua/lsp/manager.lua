local M = {}
local utils = require "utils"
local configs_dir = utils.join_paths(get_runtime_dir(), "lvim", "lua", "lsp", "providers")
local ftplugin_dir = utils.join_paths(get_runtime_dir(), "lvim", "ftplugin")

function M.init_defaults(languages)
  languages = languages or lvim.ensure_configured
  for _, entry in ipairs(languages) do
    if not lvim.lang[entry] then
      lvim.lang[entry] = {
        formatters = {},
        linters = {},
      }
    end
  end
end

function M.ensure_configured(languages)
  local status_ok, lspinstall = pcall(require, "lspinstall")
  if not status_ok then
    return
  end
  local installer_supported_languages = lspinstall.available_servers()
  for _, entry in ipairs(languages) do
    if vim.tbl_contains(installer_supported_languages, entry) then
      if not lspinstall.is_server_installer(entry) then
        lspinstall.install_server(entry)
      end
    end
  end
end

function M.gen_providers_configs()
  local configs = require "lsp.templates"
  for lang, config in pairs(configs) do
    -- make sure the directory exists
    if config.lsp and config.lsp.provider then
      vim.fn.mkdir(configs_dir, "p")
      local filename = utils.join_paths(configs_dir, lang .. ".lua")
      local prefix = [[local opts = ]]
      local postfix = "return opts"
      utils.write_file(filename, prefix .. vim.inspect(config) .. "\n" .. postfix, "w")
      -- local setup_cmd = [[ require("lsp").setup("]] .. lang .. [[", opts)]]
      -- write_async(filename, prefix .. vim.inspect(config) .. "\n" .. setup_cmd, "w")
    else
      vim.fn.mkdir(ftplugin_dir, "p")
      local filename = utils.join_paths(ftplugin_dir, lang .. ".lua")
      local prefix = [[local opts = ]]
      local postfix = "return opts"
      utils.write_file(filename, prefix .. vim.inspect(config) .. "\n" .. postfix, "w")
    end
  end
end

return M
