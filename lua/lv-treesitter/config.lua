O.treesitter = {
  ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {},
  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
    disable = { "latex" },
  },
  context_commentstring = {
    enable = false,
    config = { css = "// %s" },
  },
  -- indent = {enable = true, disable = {"python", "html", "javascript"}},
  -- TODO seems to be broken
  indent = { enable = { "javascriptreact" } },
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

-- -- TODO refactor treesitter
-- -- @usage pass a table with your desired languages
-- treesitter = {
--   ensure_installed = "all",
--   ignore_install = { "haskell" },
--   highlight = { enabled = true },
--   -- The below are for treesitter-textobjects plugin
--   textobj_prefixes = {
--     goto_next = "]", -- Go to next
--     goto_previous = "[", -- Go to previous
--     inner = "i", -- Select inside
--     outer = "a", -- Selct around
--     swap = "<leader>a", -- Swap with next
--   },
--   textobj_suffixes = {
--     -- Start and End respectively for the goto keys
--     -- for other keys it only uses the first
--     ["function"] = { "f", "F" },
--     ["class"] = { "m", "M" },
--     ["parameter"] = { "a", "A" },
--     ["block"] = { "k", "K" },
--     ["conditional"] = { "i", "I" },
--     ["call"] = { "c", "C" },
--     ["loop"] = { "l", "L" },
--     ["statement"] = { "s", "S" },
--     ["comment"] = { "/", "?" },
--   },
--   -- The below is for treesitter hint textobjects plugin
--   hint_labels = { "h", "j", "f", "d", "n", "v", "s", "l", "a" },
-- },
