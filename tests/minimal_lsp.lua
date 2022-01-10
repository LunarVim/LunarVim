local on_windows = vim.loop.os_uname().version:match "Windows"

local function join_paths(...)
  local path_sep = on_windows and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv "TEMP" or "/tmp"

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

-- Choose whether to use the executable that's managed by lsp-installer
local use_lsp_installer = true

local function load_plugins()
  require("packer").startup {
    {
      "wbthomason/packer.nvim",
      "neovim/nvim-lspconfig",
      { "williamboman/nvim-lsp-installer", disable = not use_lsp_installer },
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

_G.load_config = function()
  vim.lsp.set_log_level "trace"
  require("vim.lsp.log").set_format_func(vim.inspect)
  local nvim_lsp = require "lspconfig"
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float(0,{scope='line'})<CR>", opts)
    buf_set_keymap("n", "<space>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "<space>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<space>li", "<cmd>LspInfo<CR>", opts)
    buf_set_keymap("n", "<space>lI", "<cmd>LspInstallInfo<CR>", opts)
  end

  -- Add the server that troubles you here, e.g. "clangd", "pyright", "tsserver"
  local name = "sumneko_lua"

  local setup_opts = {
    on_attach = on_attach,
  }

  if use_lsp_installer then
    local server_available, server = require("nvim-lsp-installer.servers").get_server(name)
    if not server_available then
      server:install()
    end
    local default_opts = server:get_default_options()
    setup_opts.cmd_env = default_opts.cmd_env
  end

  if not name then
    print "You have not defined a server name, please edit minimal_init.lua"
  end
  if not nvim_lsp[name].document_config.default_config.cmd and not setup_opts.cmd then
    print [[You have not defined a server default cmd for a server
      that requires it please edit minimal_init.lua]]
  end

  nvim_lsp[name].setup(setup_opts)
  print [[You can find your log at $HOME/.cache/nvim/lsp.log. Please paste in a github issue under a details tag as described in the issue template.]]
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  load_plugins()
  require("packer").sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  require("packer").sync()
  _G.load_config()
end
