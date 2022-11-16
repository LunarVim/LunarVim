local M = {}
local Log = require "lvim.core.log"

function M.config()
  lvim.builtin.treesitter = {
    on_config_done = nil,

    -- A list of parser names, or "all"
    ensure_installed = {},

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    -- A directory to install the parsers into.
    -- By default parsers are installed to either the package dir, or the "site" dir.
    -- If a custom path is used (not nil) it must be added to the runtimepath.
    parser_install_dir = nil,

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    matchup = {
      enable = false, -- mandatory, false will disable the whole extension
      -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        if vim.tbl_contains({ "latex" }, lang) then
          return true
        end

        local max_filesize = 1024 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          if lvim.builtin.illuminate.active then
            pcall(require("illuminate").pause_buf)
          end

          vim.schedule(function()
            vim.api.nvim_buf_call(buf, function()
              vim.cmd "setlocal noswapfile noundofile"

              if vim.tbl_contains({ "json" }, lang) then
                vim.cmd "NoMatchParen"
                vim.cmd "syntax off"
                vim.cmd "syntax clear"
                vim.cmd "setlocal nocursorline nolist bufhidden=unload"

                vim.api.nvim_create_autocmd({ "BufDelete" }, {
                  callback = function()
                    vim.cmd "DoMatchParen"
                    vim.cmd "syntax on"
                  end,
                  buffer = buf,
                })
              end
            end)
          end)

          Log:info "File larger than 1MB, turned off treesitter for this buffer"

          return true
        end
      end,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    autotag = { enable = false },
    textobjects = {
      swap = {
        enable = false,
        -- swap_next = textobj_swap_keymaps,
      },
      -- move = textobj_move_keymaps,
      select = {
        enable = false,
        -- keymaps = textobj_sel_keymaps,
      },
    },
    textsubjects = {
      enable = false,
      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    rainbow = {
      enable = false,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    },
  }
end

---@class bundledParsersOpts
---@field name_only boolean
---@field filter function

---Retrives a list of bundled parsers paths (any parser not found in default `install_dir`)
---@param opts bundledParsersOpts
---@return string[]
local function get_parsers(opts)
  opts = opts or {}
  opts.filter = opts.filter or function()
    return true
  end

  local bundled_parsers = vim.tbl_filter(opts.filter, vim.api.nvim_get_runtime_file("parser/*.so", true))

  if opts.name_only then
    bundled_parsers = vim.tbl_map(function(parser)
      return vim.fn.fnamemodify(parser, ":t:r")
    end, bundled_parsers)
  end

  return bundled_parsers
end

---Checks if parser is installed with nvim-treesitter
---@param lang string
---@return boolean
local function is_installed(lang)
  local configs = require "nvim-treesitter.configs"
  local result = get_parsers {
    filter = function(parser)
      local install_dir = configs.get_parser_install_dir()
      return vim.startswith(parser, install_dir) and (vim.fn.fnamemodify(parser, ":t:r") == lang)
    end,
  }
  local parser_file = result and result[1] or ""
  local stat = vim.loop.fs_stat(parser_file)
  return stat and stat.type == "file"
end

local function ensure_updated_bundled()
  local configs = require "nvim-treesitter.configs"
  local bundled_parsers = get_parsers {
    name_only = true,
    filter = function(parser)
      local install_dir = configs.get_parser_install_dir()
      return not vim.startswith(parser, install_dir)
    end,
  }

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local missing = vim.tbl_filter(function(parser)
        return not is_installed(parser)
      end, bundled_parsers)

      if #missing > 0 then
        vim.cmd { cmd = "TSInstall", args = missing, bang = true }
      end
    end,
  })
end

function M.setup()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    Log:debug "headless mode detected, skipping running setup for treesitter"
    return
  end

  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    Log:error "Failed to load nvim-treesitter.configs"
    return
  end

  local opts = vim.deepcopy(lvim.builtin.treesitter)

  treesitter_configs.setup(opts)

  ensure_updated_bundled()

  if lvim.builtin.treesitter.on_config_done then
    lvim.builtin.treesitter.on_config_done(treesitter_configs)
  end
end

M.get_parsers = get_parsers
M.is_installed = is_installed

return M
