-- if not package.loaded['which-key'] then
--  return
-- end
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

-- Set leader
if O.leader_key == " " or O.leader_key == "space" then
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "
else
  vim.api.nvim_set_keymap("n", O.leader_key, "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = O.leader_key
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

-- no hl
vim.api.nvim_set_keymap("n", "<Leader>h", ':let @/=""<CR>', { noremap = true, silent = true })

-- explorer

vim.api.nvim_set_keymap(
  "n",
  "<Leader>e",
  ":lua require'lv-nvimtree'.toggle_tree()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<Leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- dashboard
vim.api.nvim_set_keymap("n", "<Leader>;", ":Dashboard<CR>", { noremap = true, silent = true })

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", { noremap = true, silent = true })

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })

-- open lv-config
vim.api.nvim_set_keymap(
  "n",
  "<leader>.",
  ":e " .. CONFIG_PATH .. "/lv-config.lua<CR>",
  { noremap = true, silent = true }
)

local mappings = {

  ["."] = "LunarConfig",
  ["/"] = "Comment",
  ["c"] = "Close Buffer",
  ["e"] = "Explorer",
  ["f"] = "Find File",
  ["h"] = "No Highlight",
  [";"] = "Dashboard",
  b = {
    name = "Buffers",
    j = { "<cmd>BufferPick<cr>", "jump to buffer" },
    f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
    w = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = {
      "<cmd>BufferCloseAllButCurrent<cr>",
      "close all but current buffer",
    },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = {
      "<cmd>BufferCloseBuffersRight<cr>",
      "close all BufferLines to the right",
    },
    D = {
      "<cmd>BufferOrderByDirectory<cr>",
      "sort BufferLines automatically by directory",
    },
    L = {
      "<cmd>BufferOrderByLanguage<cr>",
      "sort BufferLines automatically by language",
    },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Reload" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.stop()<cr>", "Quit" },
  },
  g = {
    name = "Git",
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>Neoformat<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<cr>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<cr>", "Prev Diagnostic" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = {
      O.plugin.symbol_outline.active and "<cmd>SymbolsOutline<cr>" or "<cmd> Telescope lsp_document_symbols<cr>",
      "Document Symbols",
    },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
  },
  S = {
    name = "Session",
    s = { "<cmd>SessionSave<cr>", "Save Session" },
    l = { "<cmd>SessionLoad<cr>", "Load Session" },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

-- if O.plugin.trouble.active then
--   mappings["d"] = {
--     name = "Diagnostics",
--     t = { "<cmd>TroubleToggle<cr>", "trouble" },
--     w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
--     d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
--     q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
--     l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
--     r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
--   }
-- end

if O.plugin.symbol_outline.active then
  vim.api.nvim_set_keymap("n", "<leader>o", ":SymbolsOutline<CR>", { noremap = true, silent = true })
  mappings["o"] = "Symbols outline"
end

if O.plugin.ts_playground.active then
  vim.api.nvim_set_keymap("n", "<leader>Th", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
  mappings[""] = "Highlight Capture"
end

if O.plugin.zen.active then
  vim.api.nvim_set_keymap("n", "<leader>z", ":ZenMode<CR>", { noremap = true, silent = true })
  mappings["z"] = "Zen"
end
if O.plugin.floatterm.active then
  vim.api.nvim_set_keymap("n", "<leader>gg", "<CMD>lua _G.__fterm_lazygit()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "t",
    "<A-i>",
    "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "<A-l>", "<CMD>lua _G.__fterm_lazygit()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "t",
    "<A-l>",
    "<C-\\><C-n><CMD>lua _G.__fterm_lazygit()<CR>",
    { noremap = true, silent = true }
  )
  mappings["gg"] = "LazyGit"
end
if O.plugin.telescope_project.active then
  -- open projects
  vim.api.nvim_set_keymap(
    "n",
    "<leader>P",
    ":lua require'telescope'.extensions.project.project{}<CR>",
    { noremap = true, silent = true }
  )
  mappings["P"] = "Projects"
end

-- [";"] = "Dashboard",

if O.lang.latex.active then
  mappings["L"] = {
    name = "+Latex",
    c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
    f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
    i = { "<cmd>VimtexInfo<cr>", "Project Information" },
    s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
    t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
    v = { "<cmd>VimtexView<cr>", "View PDF" },
  }
end

if O.lushmode then
  mappings["L"] = {
    name = "+Lush",
    l = { ":Lushify<cr>", "Lushify" },
    x = { ":lua require('lush').export_to_buffer(require('lush_theme.cool_name'))", "Lush Export" },
    t = { ":LushRunTutorial<cr>", "Lush Tutorial" },
    q = { ":LushRunQuickstart<cr>", "Lush Quickstart" },
  }
end

-- for _, v in pairs(O.user_which_key) do
-- end
for k, v in pairs(O.user_which_key) do
  mappings[k] = v
  -- table.insert(mappings, O.user_which_key[1])
  -- print(k)
  --   print(v)
end

local wk = require "which-key"
wk.register(mappings, opts)
