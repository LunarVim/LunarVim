local utils = {}

-- recursive Print (structure, limit, separator)
local function r_inspect_settings(structure, limit, separator)
  limit = limit or 100 -- default item limit
  separator = separator or "." -- indent string
  if limit < 1 then
    print "ERROR: Item limit reached."
    return limit - 1
  end
  if structure == nil then
    io.write("-- O", separator:sub(2), " = nil\n")
    return limit - 1
  end
  local ts = type(structure)

  if ts == "table" then
    for k, v in pairs(structure) do
      -- replace non alpha keys with ["key"]
      if tostring(k):match "[^%a_]" then
        k = '["' .. tostring(k) .. '"]'
      end
      limit = r_inspect_settings(v, limit, separator .. "." .. tostring(k))
      if limit < 0 then
        break
      end
    end
    return limit
  end

  if ts == "string" then
    -- escape sequences
    structure = string.format("%q", structure)
  end
  separator = separator:gsub("%.%[", "%[")
  if type(structure) == "function" then
    -- don't print functions
    io.write("-- lvim", separator:sub(2), " = function ()\n")
  else
    io.write("lvim", separator:sub(2), " = ", tostring(structure), "\n")
  end
  return limit - 1
end

function utils.generate_settings()
  -- Opens a file in append mode
  local file = io.open("lv-settings.lua", "w")

  -- sets the default output file as test.lua
  io.output(file)

  -- write all `lvim` related settings to `lv-settings.lua` file
  r_inspect_settings(lvim, 10000, ".")

  -- closes the open file
  io.close(file)
end

-- autoformat
function utils.toggle_autoformat()
  if lvim.format_on_save then
    require("core.autocmds").define_augroups {
      autoformat = {
        {
          "BufWritePre",
          "*",
          ":silent lua vim.lsp.buf.formatting_sync()",
        },
      },
    }
  end

  if not lvim.format_on_save then
    vim.cmd [[
      if exists('#autoformat#BufWritePre')
        :autocmd! autoformat
      endif
    ]]
  end
end

function utils.reload_lv_config()
  vim.cmd "source ~/.local/share/lunarvim/lvim/lua/settings.lua"
  vim.cmd("source " .. USER_CONFIG_PATH)
  vim.cmd "source ~/.local/share/lunarvim/lvim/lua/plugins.lua"
  local plugins = require "plugins"
  local plugin_loader = require("plugin-loader").init()
  utils.toggle_autoformat()
  plugin_loader:load { plugins, lvim.plugins }
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
  require("keymappings").setup()
  -- vim.cmd ":PackerClean"
end

function utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function utils.get_active_client_by_ft(filetype)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == lvim.lang[filetype].lsp.provider then
      return client
    end
  end
  return nil
end

--- Extends a list-like table with the unique values of another list-like table.
---
--- NOTE: This mutates dst!
---
--@see |vim.tbl_extend()|
---
--@param dst list which will be modified and appended to.
--@param src list from which values will be inserted.
--@param start Start index on src. defaults to 1
--@param finish Final index on src. defaults to #src
--@returns dst
function utils.list_extend_unique(dst, src, start, finish)
  vim.validate {
    dst = { dst, "t" },
    src = { src, "t" },
    start = { start, "n", true },
    finish = { finish, "n", true },
  }
  for i = start or 1, finish or #src do
    if not vim.tbl_contains(dst, src[i]) then
      table.insert(dst, src[i])
    end
  end
  return dst
end

function utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

function utils.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

function utils.lvim_log(msg)
  if lvim.debug then
    vim.notify(msg, vim.log.levels.DEBUG)
  end
end

return utils

-- TODO: find a new home for these autocommands
