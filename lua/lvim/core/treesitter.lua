local M = {}
local Log = require "lvim.core.log"

M.config = function()
  lvim.builtin.treesitter = {
    on_config_done = nil,
    ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {},
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
            vim.cmd "IlluminatePauseBuf"
          end
          vim.b.indent_blankline_use_treesitter = false
          vim.b.indent_blankline_show_current_context = false

          if vim.tbl_contains({ "json" }, lang) then
            vim.cmd "NoMatchParen"
            vim.cmd "syntax clear"

            vim.api.nvim_create_autocmd({ "BufUnload" }, {
              command = "DoMatchParen",
              buffer = buf,
            })
          end

          vim.notify "File larger than 1MB, turned off treesitter"

          return true
        else
          vim.b.indent_blankline_use_treesitter = lvim.builtin.indentlines.options.use_treesitter
          vim.b.indent_blankline_show_current_context = lvim.builtin.indentlines.options.show_current_context

          if vim.opt.foldexpr:get() == "nvim_treesitter#foldexpr()" then
            vim.opt_local.foldmethod = "expr"
          end
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

M.setup = function()
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

  if vim.opt.foldmethod:get() == "expr" and vim.opt.foldexpr:get() == "nvim_treesitter#foldexpr()" then
    vim.opt.foldmethod = "manual"
  end

  vim.g.indent_blankline_use_treesitter = false
  vim.g.indent_blankline_show_current_context = false

  if lvim.builtin.treesitter.on_config_done then
    lvim.builtin.treesitter.on_config_done(treesitter_configs)
  end
end

return M
