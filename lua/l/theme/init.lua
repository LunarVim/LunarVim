--- Theme layer
-- @module l.theme

local plug = require("c.plug")
local bind_cmd = require("c.keybind").bind_command
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local vg = vim.g      -- vim (global) variables table
local vo = vim.o      -- vim options table
local api = vim.api   -- exposed vim API for running nvim commands

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("christianchiarulli/onedark.vim")
  plug.add_plugin("vim-airline/vim-airline")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  
  --[[
    Enables syntax highlighing and colorscheme
    Note: For some reason, we have to force a refresh for
          airline to initialize with our colorscheme colors
  --]]
  autocmd.bind_vim_enter(function()
    api.nvim_command("colorscheme onedark")
    vim.cmd("AirlineRefresh")
  end)
  
  autocmd.bind("VimEnter,Colorscheme *", function()
    vo.termguicolors = true
    vim.cmd("hi Comment cterm=italic")
    vim.cmd("hi LineNr ctermbg=NONE guibg=NONE")
  end)

  vo.showtabline = 2                        -- Always show tabs

  -- onedark global variables
  vg.onedark_hide_endofbuffer = true        -- Cleaner look by hiding the `~` buffer extra lines
  vg.onedark_terminal_italics = true        -- Enable italics
  vg.onedark_termcolors = 256               -- Enable better color support
  
  -- airline global variables
  vg.webdevicons_enable_airline_tabline = 1 -- Enable special characters in tabline
  vg.airline_powerline_fonts = 1            -- Enable powerline fonts
  vg.airline_left_sep = ""                  -- Clear out airline separators
  vg.airline_right_sep = ""                 -- Clear out airline separators
  vg.airline_right_alt_sep = ""             -- Clear out airline separators
  vg.airline_theme = "onedark"              -- Switch to your current theme  

  -- Set global variable prefix for vim-airline to keep things dry
  local tabline = "airline#extensions#tabline#"
  vg[tabline.."enabled"] = 1                -- Enable tabline
  vg[tabline.."left_sep"] = ""              -- Clear out left separator
  vg[tabline.."left_alt_sep"] = ""          -- Clear out left alt separator
  vg[tabline.."right_sep"] = ""             -- Clear out right separator
  vg[tabline.."right_alt_sep"] = ""         -- Clear out right alt separator
  vg[tabline.."show_splits"] = 0            -- Disables the buffer name that displays on the right of the tabline
  vg[tabline.."tabs_label"] = ""            -- Prefix for denoting Tabs
  vg[tabline.."buffers_label"] = ""         -- Prefix for denoting Buffers
  vg[tabline.."show_close_button"] = 0      -- Disable close button at end of the tabline
  vg[tabline.."formatter"] = "unique_tail"  -- Algorithm for displaying filename
  vg[tabline.."show_tab_type"] = 0          -- Disables the arrow on the tabline
  vg[tabline.."show_tab_nr"] = 0            -- Disable tab numbers
  vg[tabline.."fnamecollapse"] = 1          -- Collapse parent directories in buffer name
  vg[tabline.."fnamemod"] = ":t"            -- Just show the file name



  --[[
  Airline section formats guide

  section |  meaning
  --------|-------------------
    a	    |  displays the mode + additional flags like crypt/spell/paste
    b	    |  VCS information - branch, hunk summary
    c	    |  filename + read-only flag
    x	    |  filetype
    y	    |  file encoding[fileformat]
    z	    |  current position in the file
  --]]
  vg.airline_section_a = "Mach 2"
  vg.airline_section_y = ""

  
end

return layer
