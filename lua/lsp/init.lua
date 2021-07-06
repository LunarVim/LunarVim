-- TODO figure out why this don't work
vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>")
-- vim.cmd('nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.cmd("nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>")
vim.cmd("nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>")
-- scroll down hover doc or scroll in definition preview
-- scroll up hover doc
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = O.lsp.popup_border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = O.lsp.popup_border
  }
)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end
local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    if O.document_highlight then documentHighlight(client, bufnr) end
    if O.plugin.lsp_signature.active then 
        local lsp_signature_cfg = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            -- If you want to hook lspsaga or other signature handler, pls set to false
            doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
            -- set to 0 if you DO NOT want any API comments be shown
            -- This setting only take effect in insert mode, it does not affect signature help in normal
            -- mode, 10 by default

            floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
            fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
            hint_enable = true, -- virtual hint enable
            hint_prefix = "🐼 ", -- Panda for parameter
            hint_scheme = "String",
            use_lspsaga = false, -- set to true if you want to use lspsaga popup
            hi_parameter = "Search", -- how your parameter will be highlight
            max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
            -- to view the hiding contents
            max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
            handler_opts = {
                border = "shadow" -- double, single, shadow, none
            },
            extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
            -- deprecate !!
            -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
        }
        require"lsp_signature".on_attach(lsp_signature_cfg)
    end

end

function lsp_config.tsserver_on_attach(client, bufnr)
    -- lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        import_all_timeout = 5000, -- ms

        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = O.lang.tsserver.linter,
        eslint_config_fallback = nil,
        eslint_enable_diagnostics = true,

        -- formatting
        enable_formatting = O.lang.tsserver.autoformat,
        formatter = O.lang.tsserver.formatter,
        formatter_config_fallback = nil,

        -- parentheses completion
        complete_parens = false,
        signature_help_in_parens = false,

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
    }

    -- required to fix code action ranges
    ts_utils.setup_client(client)

    -- TODO: keymap these?
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
end


require('lv-utils').define_augroups({
    _general_lsp = {
        {'FileType', 'lspinfo', 'nnoremap <silent> <buffer> q :q<CR>'},
    }
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"pyright", "tsserver"}
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
return lsp_config
