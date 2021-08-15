local Popup = {}

--- Create a new floating window
-- @param config The configuration passed to vim.api.nvim_open_win
-- @param win_opts The options registered with vim.api.nvim_win_set_option
-- @param buf_opts The options registered with vim.api.nvim_buf_set_option
-- @return A new popup
function Popup:new(opts)
  opts = opts or {}
  opts.layout = opts.layout or {}
  opts.win_opts = opts.win_opts or {}
  opts.buf_opts = opts.buf_opts or {}

  Popup.__index = Popup

  local default_layout = {
    relative = "editor",
    height = math.ceil(vim.o.lines * 0.9),
    width = math.floor(vim.o.columns * 0.8),
    style = "minimal",
    border = "rounded",
  }
  default_layout.col = (vim.o.columns - default_layout.width) / 2
  default_layout.row = (vim.o.lines - default_layout.height) / 2

  local obj = {
    buffer = vim.api.nvim_create_buf(false, true),
    layout = vim.tbl_deep_extend("force", default_layout, opts.layout),
    win_opts = opts.win_opts,
    buf_opts = opts.buf_opts,
  }

  setmetatable(obj, Popup)

  return obj
end

--- Display the popup with the provided content
-- @param content_provider A function accepting the popup's layout and returning the content to display
function Popup:display(content_provider)
  self.win_id = vim.api.nvim_open_win(self.buffer, true, self.layout)
  vim.lsp.util.close_preview_autocmd({ "BufHidden", "BufLeave" }, self.win_id)

  local lines = content_provider(self.layout)
  vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)

  -- window options
  for key, value in pairs(self.win_opts) do
    vim.api.nvim_win_set_option(self.win_id, key, value)
  end

  -- buffer options
  for key, value in pairs(self.buf_opts) do
    vim.api.nvim_buf_set_option(self.buffer, key, value)
  end
end

return Popup
