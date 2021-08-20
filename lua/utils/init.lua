local utils = {}
local Log = require "core.log"
local uv = vim.loop

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
    if Log:get_default() then
      Log:get_default().info "Format on save active"
    end
  end

  if not lvim.format_on_save then
    vim.cmd [[
      if exists('#autoformat#BufWritePre')
        :autocmd! autoformat
      endif
    ]]
    if Log:get_default() then
      Log:get_default().info "Format on save off"
    end
  end
end

function utils.reload_lv_config()
  require("core.lualine").config()
  vim.cmd "source ~/.local/share/lunarvim/lvim/lua/settings.lua"
  vim.cmd("source " .. USER_CONFIG_PATH)
  require("keymappings").setup() -- this should be done before loading the plugins
  vim.cmd "source ~/.local/share/lunarvim/lvim/lua/plugins.lua"
  local plugins = require "plugins"
  local plugin_loader = require("plugin-loader").init()
  utils.toggle_autoformat()
  plugin_loader:load { plugins, lvim.plugins }
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
  -- vim.cmd ":PackerClean"
  local null_ls = require "lsp.null-ls"
  null_ls.setup(vim.bo.filetype, { force_reload = true })
  Log:get_default().info "Reloaded configuration"
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

--- Checks whether a given path exists and is a file.
--@param filename (string) path to check
--@returns (bool)
function utils.is_file(filename)
  local stat = uv.fs_stat(filename)
  return stat and stat.type == "file" or false
end

return utils

-- TODO: find a new home for these autocommands
