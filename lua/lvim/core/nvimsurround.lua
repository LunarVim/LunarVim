local M = {}

M.config = function()
  lvim.builtin.nvimsurround = {
    active = true,
    on_config_done = nil,
    options = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
    }
  }
end

M.setup = function()
  local surround = reload 'nvim-surround'

  surround.setup(lvim.builtin.nvimsurround.options)

  if lvim.builtin.nvimsurround.on_config_done then
    lvim.builtin.nvimsurround.on_config_done()
  end
end

return M
