local M = {}
M.config = function()
  lvim.builtin.sessionmanager = {
    active = true,
    on_config_done = nil,
    options = {
      -- sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
      -- path_replacer = '__', -- The character to which the path separator will be replaced for session files.
      -- colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
      autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit.
      -- autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
      -- autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    }
  }
end

M.setup = function()

  local status_ok, session_manager = pcall(require, "session_manager")
  if not status_ok then
    return
  end

  -- local Path = require('plenary.path')
  session_manager.setup(lvim.builtin.sessionmanager.options)

  local tele_status_ok, telescope = pcall(require, "telescope")
  if not tele_status_ok then
    return
  end

  local tele_session_status_ok, _ = pcall(telescope.load_extension, "sessions")
  if not tele_session_status_ok then
    return
  end
end

return M
