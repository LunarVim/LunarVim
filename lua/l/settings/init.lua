--- General Neovim settings
-- @module l.settings

local plug = require("c.plug")
local kb = require("c.keybind")
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local vg = vim.g      -- vim (global) variables table
local vo = vim.o      -- vim options table
local api = vim.api   -- exposed vim API for running nvim commands

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins() --[[ N/A ]] end

--- Configures vim and plugins for this layer
function layer.init_config()
  --[[
    Options currently not set, but under consideration:

      vo.autochdir  = true -- Your working directory will always be the same as your working directory
      vo.mmp = 1300 -- Maximum amount of memory (in Kbyte) to use for pattern matching
      vg["$NVIM_TUI_ENABLE_TRUE_COLOR"] = true  -- Enable true color
      util.set_win_opt("foldcolumn", "2") -- Folding abilities
  --]]

  local format = vo.formatoptions
  vo.formatoptions = string.gsub(format, "cro", "") -- Stop newline continution of comments
  vo.iskeyword = vo.iskeyword.."-"                  -- Treat dash separated words as a word text object"
  
  if not vg.vscode then
    -- Enables syntax highlighing
    autocmd.bind_vim_enter(function()
      api.nvim_command("syntax enable")
    end)

    -- Attempt to force write even if user does not have permission
    kb.bind_command(mode.COMMAND, "w!!", "w !sudo tee %")
    
    -- Set general opts
    vo.autoindent    = true               -- Good auto indent
    vo.background    = "dark"             -- Tell vim what the background color looks like
    vo.backup        = false              -- This is recommended by coc
    vo.clipboard     = "unnamedplus"      -- Copy paste between vim and everything else
    vo.cmdheight     = 2                  -- More space for displaying messages
    vo.encoding      = "utf-8"            -- The encoding displayed 
    vo.expandtab     = true               -- Converts tabs to spaces
    vo.fileencoding  = "utf-8"            -- The encoding written to file
    vo.guifont       = "Hack Nerd Font"   -- Enable font with special characters
    vo.hidden        = true               -- Required to keep multiple buffers open multiple buffers
    vo.incsearch     = true               -- Enable incremental searching
    vo.laststatus    = 2                  -- Always display the status line
    vo.mouse         = "a"                -- Enable your mouse
    vo.pumheight     = 10                 -- Makes popup menu smaller
    vo.ruler         = true               -- Show the cursor position all the time
    vo.shiftwidth    = 2                  -- Change the number of space characters inserted for indentation
    vo.showmode      = false              -- We don't need to see things like -- INSERT -- anymore
    vo.showtabline   = 2                  -- Always show tabs 
    vo.smartindent   = true               -- Makes indenting smart
    vo.smarttab      = true               -- Makes tabbing smarter will realize you have 2 vs 4
    vo.splitbelow    = true               -- Horizontal splits will automatically be below
    vo.splitright    = true               -- Vertical splits will automatically be to the right
    vo.tabstop       = 2                  -- Insert 2 spaces for a tab
    vo.timeoutlen    = 100                -- By default timeoutlen is 1000 ms
    vo.updatetime    = 300                -- Faster completion
    vo.writebackup   = false              -- This is recommended by coc
    vo.shortmess     = vo.shortmess.."c"  -- Don't pass messages to |ins-completion-menu|.   
    
    -- Set buffer opts that don't repond to vim.o changes
    util.set_buf_opt("textwidth", 120)
    
    -- Set window opts that don't repond to vim.o changes
    util.set_win_opt("colorcolumn", "120")     -- Display ruler at character position
    util.set_win_opt("conceallevel", 0)        -- So that I can see `` in markdown files
    util.set_win_opt("cursorline", true)       -- Enable highlighting of the current line
    util.set_win_opt("number", true)           -- Line numbers
    util.set_win_opt("relativenumber", true)   -- Display relative line numbers
    util.set_win_opt("signcolumn", "yes")      -- Always show the signcolumn, otherwise it would shift the text each time
    util.set_win_opt("t_Co", "256")            -- Support 256 colors
    util.set_win_opt("wrap", false)            -- Display long lines as just one line
  end
end

return layer
