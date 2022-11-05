local M = {}

local join_paths = require("lvim.utils").join_paths

function M.config()
  lvim.builtin.mason = {
    ui = {
      border = "rounded",
      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
      },
    },

    -- NOTE: should be available in $PATH
    install_root_dir = join_paths(vim.fn.stdpath "data", "mason"),

    -- NOTE: already handled in the bootstrap stage
    PATH = "skip",

    pip = {
      -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
      -- and is not recommended.
      --
      -- Example: { "--proxy", "https://proxyserver" }
      install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    github = {
      -- The template URL to use when downloading assets from GitHub.
      -- The placeholders are the following (in order):
      -- 1. The repository (e.g. "rust-lang/rust-analyzer")
      -- 2. The release version (e.g. "v0.3.0")
      -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
  }
end

function M.get_prefix()
  local default_prefix = join_paths(vim.fn.stdpath "data", "mason")
  return vim.tbl_get(lvim.builtin, "mason", "install_root_dir") or default_prefix
end

---@param append boolean|nil whether to append to prepend to PATH
local function add_to_path(append)
  local p = join_paths(M.get_prefix(), "bin")
  if vim.env.PATH:match(p) then
    return
  end
  local string_separator = vim.loop.os_uname().version:match "Windows" and ";" or ":"
  if append then
    vim.env.PATH = vim.env.PATH .. string_separator .. p
  else
    vim.env.PATH = p .. string_separator .. vim.env.PATH
  end
end

function M.bootstrap()
  add_to_path()
end

function M.setup()
  local status_ok, mason = pcall(reload, "mason")
  if not status_ok then
    return
  end

  add_to_path(lvim.builtin.mason.PATH == "append")

  mason.setup(lvim.builtin.mason)
end

return M
