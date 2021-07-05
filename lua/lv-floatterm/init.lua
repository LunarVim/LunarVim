local M = {}

M.config = function()
    require'FTerm'.setup({
        dimensions  = {
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5
        },
        border = 'single' -- or 'double'
    })

    -- Create LazyGit Terminal
    local term = require("FTerm.terminal")
    local lazy = term:new():setup({
        cmd = "lazygit",
        dimensions = {
            height = 0.9,
            width = 0.9
        }
    })

     -- Use this to toggle gitui in a floating terminal
    function _G.__fterm_lazygit()
        lazy:toggle()
    end
end

return M

