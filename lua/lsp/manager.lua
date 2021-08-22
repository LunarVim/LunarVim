local M = {}

local uv = vim.loop

local function write_async(path, txt, flag)
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

function M.load_configs()
  lvim.lang = require "lsp.templates"
end

function M.gen_ftplugin()
  local configs = require("lsp.templates").configs
  for k, v in pairs(configs) do
    -- local ft_runtime_dir = uv.os_homedir() .. "/.local/share/lunarvim/site/ftplugin"
    local ft_runtime_dir = uv.os_homedir() .. "/.local/share/lunarvim/lvim/test"
    local filename = ft_runtime_dir .. "/" .. k .. ".lua"
    local prefix = [[local opts = ]]
    local setup_cmd = [[ require("lsp").setup("]] .. k .. [[", opts.lsp.setup)]]
    write_async(filename, prefix .. vim.inspect(v) .. "\n" .. setup_cmd, "w")
  end
end

function M.global_setup()
  vim.lsp.protocol.CompletionItemKind = lvim.lsp.completion.item_kind

  for _, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require("lsp.handlers").setup()

  local null_status_ok, null_ls = pcall(require, "null-ls")
  if null_status_ok then
    null_ls.config()
    require("lspconfig")["null-ls"].setup(lvim.lsp.null_ls.setup)
  end

  local utils = require "utils"

  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    lsp_settings.setup {
      config_home = utils.join_paths(get_config_dir(), "lsp-settings"),
    }
  end
end

return M
