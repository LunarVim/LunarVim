local M = {}
local Log = require "core.log"
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
    documentation = {
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 120,
      min_width = 60,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1,
    },
    -- documentation = true,

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

    keymap = {
      values = {
        insert_mode = {
          -- ["<Tab>"] = { 'pumvisible() ? "<C-n>" : "<Tab>"', { silent = true, noremap = true, expr = true } },
          -- ["<S-Tab>"] = { 'pumvisible() ? "<C-p>" : "<S-Tab>"', { silent = true, noremap = true, expr = true } },
          ["<C-Space>"] = { "compe#complete()", { silent = true, noremap = true, expr = true } },
          ["<C-e>"] = { "compe#close('<C-e>')", { silent = true, noremap = true, expr = true } },
          ["<C-f>"] = { "compe#scroll({ 'delta': +4 })", { silent = true, noremap = true, expr = true } },
          ["<C-d>"] = { "compe#scroll({ 'delta': -4 })", { silent = true, noremap = true, expr = true } },
        },
      },
      opts = {
        insert_mode = { noremap = true, silent = true, expr = true },
      },
    },
  }
end

M.setup = function()
  vim.g.vsnip_snippet_dir = lvim.vsnip_dir

  local status_ok, compe = pcall(require, "compe")
  if not status_ok then
    Log:get_default().error "Failed to load compe"
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

  local is_emmet_active = function()
    local utils = require "lsp.utils"
    if utils.is_client_active "emmet_ls" then
      return true
    end
    return false
  end

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif vim.fn.call("vsnip#jumpable", { 1 }) == 1 then
      return t "<Plug>(vsnip-jump-next)"
    elseif is_emmet_active() then
      return vim.fn["compe#complete"]()
    elseif check_back_space() then
      return t "<Tab>"
    else
      return t "<Tab>"
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

  local keymap = require "keymappings"
  keymap.load(lvim.builtin.compe.keymap.values, lvim.builtin.compe.keymap.opts)

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
end

return M
