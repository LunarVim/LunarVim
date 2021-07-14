local m = {
  files = {},
}
local uv = vim.loop

--- Watch a file for updates
-- See https://github.com/luvit/luv/blob/master/docs.md#file-system-operations
-- @param filename The relative file path
-- @param callback The function to call on updates
-- @return self
function m:watch(filename, callback)
  local fullpath = vim.api.nvim_call_function("fnamemodify", { filename, ":p" })
  local watcher = uv.new_fs_event()
  self.files[filename] = true

  local function on_change(err, _, events)
    if not err == nil then
      error("Error: ", err)
      self:unwatch(filename)
    end

    watcher:stop()
    if self.files[filename] == nil then
      return
    end
    callback(filename, events)
    if self.files[filename] == nil then
      return
    end
    watcher:start(fullpath, {}, vim.schedule_wrap(on_change))
  end

  watcher:start(fullpath, {}, vim.schedule_wrap(on_change))
  return self
end

--- Unwatch a file
-- @param filename The file to unwatch
-- @return self
function m:unwatch(filename)
  self.files[filename] = nil
  return self
end

return m
