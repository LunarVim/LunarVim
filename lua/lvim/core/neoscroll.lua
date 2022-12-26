local M = {}
M.config = function()
  lvim.builtin.neoscroll = {
    active = true,
    on_config_done = nil,
    options = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
    }
  }
end

M.setup = function()
  local status_ok, neoscroll = pcall(require, "neoscroll")
  if not status_ok then
    return
  end
  neoscroll.setup(lvim.builtin.neoscroll.options)

  if lvim.builtin.neoscroll.on_config_done then
    lvim.builtin.neoscroll.on_config_done()
  end
end

return M
