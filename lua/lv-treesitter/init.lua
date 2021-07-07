-- TODO refacor this whole file and treesitter in general
-- if not package.loaded['nvim-treesitter'] then return end
--
-- Custom parsers
-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.make = {
--     install_info = {
--         url = "https://github.com/alemuller/tree-sitter-make", -- local path or git repo
--         files = {"src/parser.c"},
--         requires_generate_from_grammar = true
--     }
-- }
-- parser_config.just = {
--     install_info = {
--         url = "~/dev/tree-sitter-just", -- local path or git repo
--         files = {"src/parser.c"}
--     }
--     -- filetype = "just", -- if filetype does not agrees with parser name
--     -- used_by = {"bar", "baz"} -- additional filetypes that use this parser
-- }
-- Custom text objects
local textobj_prefixes = O.treesitter.textobj_prefixes
local textobj_suffixes = O.treesitter.textobj_suffixes
local textobj_sel_keymaps = {}
local textobj_swap_keymaps = {}
local textobj_move_keymaps = {
  enable = O.plugin.ts_textobjects,
  set_jumps = true, -- whether to set jumps in the jumplist
  goto_next_start = {},
  goto_next_end = {},
  goto_previous_start = {},
  goto_previous_end = {},
}
for obj, suffix in pairs(textobj_suffixes) do
  if textobj_prefixes["goto_next"] ~= nil then
    textobj_move_keymaps["goto_next_start"][textobj_prefixes["goto_next"] .. suffix[1]] = "@" .. obj .. ".outer"
    textobj_move_keymaps["goto_next_end"][textobj_prefixes["goto_next"] .. suffix[2]] = "@" .. obj .. ".outer"
  end
  if textobj_prefixes["goto_prev"] ~= nil then
    textobj_move_keymaps["goto_previous_start"][textobj_prefixes["goto_previous"] .. suffix[2]] = "@" .. obj .. ".outer"
    textobj_move_keymaps["goto_previous_end"][textobj_prefixes["goto_previous"] .. suffix[1]] = "@" .. obj .. ".outer"
  end

  if textobj_prefixes["inner"] ~= nil then
    textobj_sel_keymaps[textobj_prefixes["inner"] .. suffix[1]] = "@" .. obj .. ".inner"
  end
  if textobj_prefixes["outer"] ~= nil then
    textobj_sel_keymaps[textobj_prefixes["outer"] .. suffix[1]] = "@" .. obj .. ".outer"
  end

  if textobj_prefixes["swap"] ~= nil then
    textobj_swap_keymaps[textobj_prefixes["swap"] .. suffix[1]] = "@" .. obj .. ".outer"
  end
end
vim.g.ts_hint_textobject_keys = O.treesitter.hint_labels -- Requires https://github.com/mfussenegger/nvim-ts-hint-textobject/pull/2

-- Add which key menu entries
local status, wk = pcall(require, "which-key")
if status then
  local normal = {
    mode = "n", -- Normal mode
  }
  local operators = {
    mode = "o", -- Operator mode
  }
  wk.register(textobj_sel_keymaps, operators)
  wk.register({
    ["m"] = "Hint Objects",
    ["."] = "Textsubject",
    [";"] = "Textsubject-big",
  }, operators)
  wk.register(textobj_swap_keymaps, normal)
  wk.register({
    [textobj_prefixes["swap"]] = "Swap",
    -- [textobj_prefixes["goto_next"]] = "Jump [",
    -- [textobj_prefixes["goto_previous"]] = "Jump ]"
  }, normal)
  wk.register(textobj_move_keymaps["goto_next_start"], normal)
  wk.register(textobj_move_keymaps["goto_next_end"], normal)
  wk.register(textobj_move_keymaps["goto_previous_start"], normal)
  wk.register(textobj_move_keymaps["goto_previous_end"], normal)
end
local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter_configs.setup {
  ensure_installed = O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = O.treesitter.ignore_install,
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  highlight = {
    enable = O.treesitter.highlight.enabled, -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
    disable = { "latex" },
  },
  context_commentstring = {
    enable = O.plugin.ts_context_commentstring.active,
    config = { css = "// %s" },
  },
  -- indent = {enable = true, disable = {"python", "html", "javascript"}},
  -- TODO seems to be broken
  indent = { enable = { "javascriptreact" } },
  autotag = { enable = O.plugin.ts_autotag.active },
  textobjects = {
    swap = {
      enable = O.plugin.ts_textobjects,
      swap_next = textobj_swap_keymaps,
    },
    move = textobj_move_keymaps,
    select = {
      enable = O.plugin.ts_textobjects,
      keymaps = textobj_sel_keymaps,
    },
  },
  textsubjects = {
    enable = O.plugin.ts_textsubjects,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
  },
  playground = {
    enable = O.plugin.ts_playground.active,
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
    enable = O.plugin.ts_rainbow.active,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
}
