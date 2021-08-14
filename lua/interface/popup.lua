local M = {}

function M.new(config, win_opts, buf_opts)
  config = config or {}
  win_opts = win_opts or {}
  buf_opts = buf_opts or {}

  local default_config = {
    relative = "editor",
    height = math.ceil(vim.o.lines * 0.9),
    width = math.floor(vim.o.columns * 0.8),
    style = "minimal",
    border = "rounded",
  }
  default_config.col = (vim.o.columns - default_config.width) / 2
  default_config.row = (vim.o.lines - default_config.height) / 2

  local popup = {
    buffer = vim.api.nvim_create_buf(false, true),
    opts = vim.tbl_deep_extend("force", default_config, config),
  }
  popup.display = function(content_provider)
    popup.win_id = vim.api.nvim_open_win(popup.buffer, true, popup.opts)
    vim.lsp.util.close_preview_autocmd({ "BufHidden", "BufLeave" }, popup.win_id)

    local lines = content_provider(popup.opts)
    vim.api.nvim_buf_set_lines(popup.buffer, 0, -1, false, lines)

    -- window options
    for key, value in pairs(win_opts) do
      vim.api.nvim_win_set_option(popup.win_id, key, value)
    end

    -- buffer options
    for key, value in pairs(buf_opts) do
      vim.api.nvim_buf_set_option(popup.buffer, key, value)
    end
  end

  return popup
end

return M
