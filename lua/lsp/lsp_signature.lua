local M = {}
M.config = function()
    require "lsp_signature".on_attach({
        -- Config for Plugin goes here
        -- For available options visit github repo
        -- repo: ray-x/lsp_signature.nvim
    })
end
return M
