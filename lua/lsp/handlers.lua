-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  local config = { -- your config
    virtual_text = lvim.lsp.diagnostics.virtual_text,
    signs = lvim.lsp.diagnostics.signs,
    underline = lvim.lsp.diagnostics.underline,
    update_in_insert = lvim.lsp.diagnostics.update_in_insert,
    severity_sort = lvim.lsp.diagnostics.severity_sort,
  }
  if vim.fn.has "nvim-0.5.1" > 0 then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
      local uri = result.uri
      local bufnr = vim.uri_to_bufnr(uri)
      if not bufnr then
        return
      end

      local diagnostics = result.diagnostics
      local ok, vim_diag = pcall(require, "vim.diagnostic")
      if ok then
        -- FIX: why can't we just use vim.diagnostic.get(buf_id)?
        config.signs = true
        for i, diagnostic in ipairs(diagnostics) do
          local rng = diagnostic.range
          diagnostics[i].lnum = rng["start"].line
          diagnostics[i].end_lnum = rng["end"].line
          diagnostics[i].col = rng["start"].character
          diagnostics[i].end_col = rng["end"].character
        end
        local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)

        vim_diag.set(namespace, bufnr, diagnostics, config)
        if not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end

        local sign_names = {
          "DiagnosticSignError",
          "DiagnosticSignWarn",
          "DiagnosticSignInfo",
          "DiagnosticSignHint",
        }
        for i, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
          vim.fn.sign_define(sign_names[i], { texthl = sign_names[i], text = sign.text, numhl = "" })
        end
        vim_diag.show(namespace, bufnr, diagnostics, config)
      else
        vim.lsp.diagnostic.save(diagnostics, bufnr, ctx.client_id)
        if not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end
        vim.lsp.diagnostic.display(diagnostics, bufnr, ctx.client_id, config)
      end
    end
  else
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
      local uri = params.uri
      local bufnr = vim.uri_to_bufnr(uri)
      if not bufnr then
        return
      end

      local diagnostics = params.diagnostics
      vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end
      vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
    end
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = lvim.lsp.popup_border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = lvim.lsp.popup_border,
  })
end

local function split_by_chunk(text, chunkSize)
  local s = {}
  for i = 1, #text, chunkSize do
    s[#s + 1] = text:sub(i, i + chunkSize - 1)
  end
  return s
end

function M.show_line_diagnostics()
  -- TODO: replace all this with vim.diagnostic.show_position_diagnostics()
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  local severity_highlight = {
    "LspDiagnosticsFloatingError",
    "LspDiagnosticsFloatingWarning",
    "LspDiagnosticsFloatingInformation",
    "LspDiagnosticsFloatingHint",
  }
  local ok, vim_diag = pcall(require, "vim.diagnostic")
  if ok then
    local buf_id = vim.api.nvim_win_get_buf(0)
    local win_id = vim.api.nvim_get_current_win()
    local cursor_position = vim.api.nvim_win_get_cursor(win_id)
    severity_highlight = {
      "DiagnosticFloatingError",
      "DiagnosticFloatingWarn",
      "DiagnosticFloatingInfo",
      "DiagnosticFloatingHint",
    }
    diagnostics = vim_diag.get(buf_id, { lnum = cursor_position[1] - 1 })
  end
  local lines = {}
  local max_width = vim.fn.winwidth(0) - 5
  local height = #diagnostics
  local width = 0
  local opts = {}
  local close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }
  if height == 0 then
    return
  end
  local bufnr = vim.api.nvim_create_buf(false, true)
  local diag_message
  table.sort(diagnostics, function(a, b)
    return a.severity < b.severity
  end)
  for i, diagnostic in ipairs(diagnostics) do
    local source = diagnostic.source
    diag_message = diagnostic.message:gsub("[\n\r]", " ")
    if source then
      if string.find(source, "/") then
        source = string.sub(diagnostic.source, string.find(diagnostic.source, "([%w-_]+)$"))
      end
      diag_message = string.format("%d. %s: %s", i, source, diag_message)
    else
      diag_message = string.format("%d. %s", i, diag_message)
    end
    if diagnostic.code then
      diag_message = string.format("%s [%s]", diag_message, diagnostic.code)
    end
    local msgs = split_by_chunk(diag_message, max_width)
    for _, diag in ipairs(msgs) do
      table.insert(lines, { message = diag, severity = diagnostic.severity })
      width = math.max(diag:len(), width)
    end
  end
  height = #lines
  opts = vim.lsp.util.make_floating_popup_options(width, height, opts)
  opts["style"] = "minimal"
  opts["border"] = "rounded"
  opts["focusable"] = true

  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  local winnr = vim.api.nvim_open_win(bufnr, false, opts)
  vim.api.nvim_win_set_option(winnr, "winblend", 0)
  vim.api.nvim_buf_set_var(bufnr, "lsp_floating_window", winnr)
  for i, diag in ipairs(lines) do
    vim.api.nvim_buf_set_lines(bufnr, i - 1, i - 1, 0, { diag.message })
    vim.api.nvim_buf_add_highlight(bufnr, -1, severity_highlight[diag.severity], i - 1, 0, diag.message:len())
  end

  vim.api.nvim_command(
    "autocmd QuitPre <buffer> ++nested ++once lua pcall(vim.api.nvim_win_close, " .. winnr .. ", true)"
  )
  vim.lsp.util.close_preview_autocmd(close_events, winnr)
end

return M
