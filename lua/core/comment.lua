local M = {}

M.setup = function()
 local nvim_comment = require "nvim_comment"
nvim_comment.setup()
 return nvim_comment
end

return M
