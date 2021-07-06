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

    local function is_lazygit_available()
        return vim.fn.executable("lazygit") == 1
    end

     -- Use this to toggle gitui in a floating terminal
    function _G.__fterm_lazygit()
        if is_lazygit_available() ~= true then
            print("Please install lazygit. Check documentation for more information")
            return
        end
        lazy:toggle()
    end
end

return M

