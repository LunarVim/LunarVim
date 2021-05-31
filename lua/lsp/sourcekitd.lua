local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require"lspconfig".util

-- Check if sourcekit server already defined.
if not lspconfig.sourcekit then configs['sourcekit'] = {default_config = {}} end

lspconfig.sourcekit.setup {
    cmd = { "xcrun", "sourcekit-lsp" },
    filetypes = { "swift", "objective-c", "objective-cpp" },
    root_dir = function(fname)
        return util.root_pattern('Package.swift')(fname) or
        util.find_git_ancestor(fname)
    end,
    on_attach = require'lsp'.common_on_attach
}
