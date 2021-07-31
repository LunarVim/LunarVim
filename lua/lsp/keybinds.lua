local M = {}

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
function M.preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range
  local contents = vim.api.nvim_buf_get_lines(
    bufnr,
    range.start.line - before_context,
    range["end"].line + 1 + context,
    false
  )
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype, { border = lvim.lsp.popup_border })
end

function M.preview_location_callback(_, method, result)
  local context = 15
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    M.floating_buf, M.floating_win = M.preview_location(result[1], context)
  else
    M.floating_buf, M.floating_win = M.preview_location(result, context)
  end
end

function M.PeekDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    vim.api.nvim_set_current_win(M.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, M.preview_location_callback)
  end
end

function M.PeekTypeDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    vim.api.nvim_set_current_win(M.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/typeDefinition", params, M.preview_location_callback)
  end
end

function M.PeekImplementation()
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    vim.api.nvim_set_current_win(M.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/implementation", params, M.preview_location_callback)
  end
end

function M.setup()
  if lvim.lsp.default_keybinds then
    vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
    vim.cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>"
    vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
    vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
    vim.api.nvim_set_keymap(
      "n",
      "gl",
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>',
      { noremap = true, silent = true }
    )

    vim.cmd "nnoremap <silent> gp <cmd>lua require'lsp.keybinds'.PeekDefinition()<CR>"
    vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
    vim.cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>"
    vim.cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>"
    -- vim.cmd "nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>"
    -- scroll down hover doc or scroll in definition preview
    -- scroll up hover doc
    -- vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'
  end
end

return M
