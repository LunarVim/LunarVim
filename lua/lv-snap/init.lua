local M = {}

M.config = function()
  local snap = require "snap"
  local layout = snap.get("layout").bottom
  local file = snap.config.file:with { consumer = "fzy", layout = layout }
  local vimgrep = snap.config.vimgrep:with { layout = layout }
  snap.register.command("find_files", file { producer = "ripgrep.file" })
  snap.register.command("buffers", file { producer = "vim.buffer" })
  snap.register.command("oldfiles", file { producer = "vim.oldfile" })
  snap.register.command("live_grep", vimgrep {})
end

return M
