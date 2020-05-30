--- Autocommand support
-- @module c.autocmd

local signal = require("c.signal")
local Signal = signal.Signal

local autocmd = {}

autocmd._bound_signals = {}

--- Clears out autocommands set by this module
function autocmd.init()
  vim.api.nvim_command("augroup c_autocmd")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("augroup END")
end

--- Register a callback for an autocommand
--
-- @tparam string trigger The autocommand trigger
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind(trigger, func)
  local cmd_signal = autocmd._bound_signals[trigger]
  if cmd_signal == nil then
    cmd_signal = Signal()
    autocmd._bound_signals[trigger] = cmd_signal

    local cmd = "autocmd " .. trigger .. " lua require('c.autocmd')._bound_signals['" .. trigger .."']:emit()"
    vim.api.nvim_command("augroup c_autocmd")
    vim.api.nvim_command(cmd)
    vim.api.nvim_command("augroup END")
  end

  cmd_signal:connect(func)
end

--- Register a callback for when a buffer filetype is set
--
-- @tparam string|table filetypes A filetype string, or a list of filetype strings
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_filetype(filetypes, func)
  local trigger
  if type(filetypes) == "string" then
    trigger = "FileType " .. filetypes

    -- HACK?: Workaround for the FileType autocmd not being fired on launch for some reason...
    autocmd.bind_vim_enter(function()
      if vim.bo.ft == filetypes then
        func()
      end
    end)
  elseif type(filetypes) == "table" then
    trigger = "FileType " .. table.concat(filetypes, ",")

    -- HACK?: Workaround for the FileType autocmd not being fired on launch for some reason...
    autocmd.bind_vim_enter(function()
      for _, v in pairs(filetypes) do
        if vim.bo.ft == v then
          func()
          return
        end
      end
    end)
  else
    assert(false, "`filetypes` should be a string or a table")
  end

  autocmd.bind(trigger, func)
end

--- Register a callback for when Vim launches
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_vim_enter(func)
  autocmd.bind("VimEnter *", func)
end

--- Register a callback for colorscheme changes
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_colorscheme(func)
  autocmd.bind("Colorscheme *", func)
end

--- Register a callback for when completion is done
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_complete_done(func)
  autocmd.bind("CompleteDone *", func)
end

--- Register a callback for when no key is pressed for `updatetime` in normal mode
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_cursor_hold(func)
  autocmd.bind("CursorHold *", func)
end

--- Register a callback for a window is about to be closed with :quit/:wq/:qall
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_quit_pre(func)
  autocmd.bind("QuitPre *", func)
end

--- Register a callback for after window has been closed
--
-- @tparam function func The function to call when the autocommand fires
function autocmd.bind_win_closed(func)
  autocmd.bind("WinClosed *", func)
end

return autocmd
