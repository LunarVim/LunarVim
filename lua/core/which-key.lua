local M = {}

-- Set which_key remaps with an enable condition
-- @param mapping The user defined remap
-- @param enable_mapping Function or boolean value to check if mapping should be enabled
local function remap(mapping, condition)
  -- Dont accept bad conditions
  if not (type(condition) == "function" or type(condition) == "boolean") then
    require("core.log"):error "Bad condition set for which_key mappging"
    return nil
  end

  -- Set metatable to chech enable condition
  setmetatable(mapping, {
    __index = function(_, key)
      if key == "enable_mapping" then
        if type(condition) == "function" then
          return condition()
        elseif type(condition) == "boolean" then
          return condition
        else
          -- Bad value has been set
          return nil
        end
      else
        -- Key was not found
        return nil
      end
    end,
  })

  return mapping
end

M.config = function()
  -- Conditional checks used in maps
  local function has_dap()
    return lvim.builtin.dap.active
  end
  local function has_telescope()
    return lvim.builtin.telescope.active
  end
  local function has_comment()
    return lvim.builtin.comment.active
  end
  local function has_nvimtree()
    return lvim.builtin.nvimtree.active
  end
  local function has_terminal()
    return lvim.builtin.terminal.active
  end
  local function has_treesitter()
    return lvim.builtin.treesitter.active
  end
  local function has_gitsigns()
    return lvim.builtin.gitsigns
  end

  lvim.builtin.which_key = {
    ---@usage disable which-key completely [not recommeded]
    active = true,
    on_config_done = nil,
    setup = {
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
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
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
    },
    opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    conditional_remap = remap, -- Remap helper function to setup conditional remaps
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    vmappings = {
      ["/"] = remap({ ":CommentToggle<CR>", "Comment" }, has_comment),
    },
    mappings = {
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { "<cmd>q!<CR>", "Quit" },
      ["/"] = remap({ "<cmd>CommentToggle<CR>", "Comment" }, has_comment),
      ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
      ["f"] = remap({ "<cmd>Telescope find_files<CR>", "Find File" }, has_telescope),
      ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
      e = remap({ "<cmd>NvimTreeToggle<CR>", "Explorer" }, has_nvimtree),
      b = {
        name = "Buffers",
        j = { "<cmd>BufferPick<cr>", "Jump" },
        f = remap({ "<cmd>Telescope buffers<cr>", "Find" }, has_telescope),
        b = { "<cmd>b#<cr>", "Previous" },
        w = { "<cmd>BufferWipeout<cr>", "Wipeout" },
        e = { "<cmd>BufferCloseAllButCurrent<cr>", "Close all but current" },
        h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
        l = { "<cmd>BufferCloseBuffersRight<cr>", "Close all to the right" },
        D = { "<cmd>BufferOrderByDirectory<cr>", "Sort by directory" },
        L = { "<cmd>BufferOrderByLanguage<cr>", "Sort by language" },
      },
      p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        r = { "<cmd>lua require('utils').reload_lv_config()<cr>", "Reload" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
      },
      d = remap({
        -- " Available Debug Adapters:
        -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
        -- " Adapter configuration and installation instructions:
        -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
        -- " Debug Adapter protocol:
        -- "   https://microsoft.github.io/debug-adapter-protocol/
        name = "Debug",
        t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        b = { "<cmd>lua require('dap').step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
        C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run To Cursor" },
        d = { "<cmd>lua require('dap').disconnect()<cr>", "Disconnect" },
        g = { "<cmd>lua require('dap').session()<cr>", "Get Session" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
        u = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
        p = { "<cmd>lua require('dap').pause()<cr>", "Pause Thread" },
        r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle Repl" },
        s = { "<cmd>lua require('dap').continue()<cr>", "Start" },
        q = { "<cmd>lua require('dap').close()<cr>", "Quit" },
      }, has_dap),
      g = {
        name = "Git",
        j = remap({ "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" }, has_gitsigns),
        k = remap({ "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev Hunk" }, has_gitsigns),
        l = remap({ "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame" }, has_gitsigns),
        p = remap({ "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" }, has_gitsigns),
        r = remap({ "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" }, has_gitsigns),
        R = remap({ "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Buffer" }, has_gitsigns),
        s = remap({ "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Hunk" }, has_gitsigns),
        u = remap({ "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage Hunk" }, has_gitsigns),
        o = remap({ "<cmd>Telescope git_status<cr>", "Open changed file" }, has_telescope),
        b = remap({ "<cmd>Telescope git_branches<cr>", "Checkout branch" }, has_telescope),
        c = remap({ "<cmd>Telescope git_commits<cr>", "Checkout commit" }, has_telescope),
        C = remap({ "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" }, has_telescope),
        d = remap({ "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" }, has_gitsigns),
      },
      l = {
        name = "LSP",
        a = remap({ "<cmd>lua require('core.telescope').code_actions()<cr>", "Code Action" }, has_telescope),
        d = remap({ "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" }, has_telescope),
        w = remap({ "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" }, has_telescope),
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
          "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
          "Next Diagnostic",
        },
        k = {
          "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
          "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        p = {
          name = "Peek",
          d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Definition" },
          t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
          i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Implementation" },
        },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = remap({ "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" }, has_telescope),
        S = remap({ "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" }, has_telescope),
      },
      L = {
        name = "LunarVim",
        c = {
          "<cmd>edit" .. get_config_dir() .. "/config.lua<cr>",
          "Edit config.lua",
        },
        f = remap(
          { "<cmd>lua require('core.telescope').find_lunarvim_files()<cr>", "Find LunarVim files" },
          has_telescope
        ),
        g = remap(
          { "<cmd>lua require('core.telescope').grep_lunarvim_files()<cr>", "Grep LunarVim files" },
          has_telescope
        ),
        k = { "<cmd>lua require('keymappings').print()<cr>", "View LunarVim's default keymappings" },
        i = {
          "<cmd>lua require('core.info').toggle_popup(vim.bo.filetype)<cr>",
          "Toggle LunarVim Info",
        },
        I = {
          "<cmd>lua require('core.telescope').view_lunarvim_changelog()<cr>",
          "View LunarVim's changelog",
        },
        l = {
          name = "logs",
          d = remap({
            "<cmd>lua require('core.terminal').toggle_log_view(require('core.log').get_path())<cr>",
            "view default log",
          }, has_terminal),
          D = { "<cmd>lua vim.fn.execute('edit ' .. require('core.log').get_path())<cr>", "Open the default logfile" },
          n = remap(
            { "<cmd>lua require('core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", "view neovim log" },
            has_terminal
          ),
          N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
          l = remap(
            { "<cmd>lua require('core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", "view lsp log" },
            has_terminal
          ),
          L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
          p = remap(
            { "<cmd>lua require('core.terminal').toggle_log_view('packer.nvim')<cr>", "view packer log" },
            has_terminal
          ),
          P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", "Open the Packer logfile" },
        },
        r = { "<cmd>lua require('utils').reload_lv_config()<cr>", "Reload configurations" },
        u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
      },
      s = remap({
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        p = {
          "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
          "Colorscheme with Preview",
        },
      }, has_telescope),
      T = remap({
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
      }, has_treesitter),
    },
  }
end

-- Check for leaf nodes in the lvim.builtin.which_key.(v)mappings tables
local function is_leaf_node(v)
  local command = type(v) == "string" -- Only has command
  local command_and_name = #v == 2 -- Has only two entries command, name
    and (type(v[1]) == "string" or type(v[1]) == "function") -- Command is string or func
    and (type(v[2]) == "string") -- Name is string
  local name = #v == 1 and v.name ~= nil -- Is name element

  return command_and_name or command or name
end

-- Clean up mappings for inactive core plugins
local function clean_up_inactive_mappings(mapping)
  for k, v in pairs(mapping) do
    if v.enable_mapping == false then
      -- This mapping has been explicitly disabled
      mapping[k] = nil
    elseif not is_leaf_node(v) then
      -- This page of which_key has not been disabled --> Recurse into subpages
      clean_up_inactive_mappings(v)
    end
  end
end

M.setup = function()
  local which_key = require "which-key"

  which_key.setup(lvim.builtin.which_key.setup)

  local opts = lvim.builtin.which_key.opts
  local vopts = lvim.builtin.which_key.vopts

  clean_up_inactive_mappings(lvim.builtin.which_key.mappings)
  clean_up_inactive_mappings(lvim.builtin.which_key.vmappings)

  local mappings = lvim.builtin.which_key.mappings
  local vmappings = lvim.builtin.which_key.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)

  if lvim.builtin.which_key.on_config_done then
    lvim.builtin.which_key.on_config_done(which_key)
  end
end

return M
