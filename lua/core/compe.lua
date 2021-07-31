local M = {}
M.config = function()
  lvim.builtin.compe = {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      calc = { kind = "   (Calc)" },
      vsnip = { kind = "   (Snippet)" },
      nvim_lsp = { kind = "   (LSP)" },
      nvim_lua = false,
      spell = { kind = "   (Spell)" },
      tags = false,
      vim_dadbod_completion = false,
      snippets_nvim = false,
      ultisnips = false,
      treesitter = false,
      emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
      -- for emoji press : (idk if that in compe tho)
    },
    -- FileTypes in this list won't trigger auto-complete when TAB is pressed.  Hitting TAB will insert a tab character
    exclude_filetypes = { "md", "markdown", "mdown", "mkd", "mkdn", "mdwn", "text", "txt" },
  }
end

M.setup = function()
  vim.g.vsnip_snippet_dir = lvim.vsnip_dir

  local status_ok, compe = pcall(require, "compe")
  if not status_ok then
    return
  end

  compe.setup(lvim.builtin.compe)

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col "." - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return true
    else
      return false
    end
  end

  local remap = vim.api.nvim_set_keymap

  remap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { silent = true, noremap = true, expr = true })

  remap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { silent = true, noremap = true, expr = true })

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
      return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn["compe#complete"]()
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return t "<S-Tab>"
    end
  end

  vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
  -- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true })
  vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true })
end

local is_excluded = function(file_type)
  for _, type in ipairs(lvim.builtin.compe.exclude_filetypes) do
    if type == file_type then
      return true
    end
  end
  return false
end

M.set_tab_keybindings = function()
  local file_type = vim.fn.expand "%:e"
  -- if is_excluded(file_type) == false then
  --   vim.api.nvim_buf_set_keymap(0, "i", "<Tab>", "v:lua.tab_complete()", { expr = true })
  --   vim.api.nvim_buf_set_keymap(0, "s", "<Tab>", "v:lua.tab_complete()", { expr = true })
  --   vim.api.nvim_buf_set_keymap(0, "i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  --   vim.api.nvim_buf_set_keymap(0, "s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  -- end
end
return M
