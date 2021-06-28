local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lv-config.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}
    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}

    -- Autocomplete
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require("lv-compe").config()
        end,
        event = "InsertEnter"
    }

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    use {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require("lv-nvimtree").config()
        end

    }

    -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    use {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("lv-gitsigns").config()
        end,
        event = "BufRead"
    }

    use {"folke/which-key.nvim"}
    use {"windwp/nvim-autopairs"}

    -- Comments
    use {
        "terrortylor/nvim-comment",
        cmd = "CommentToggle",
        config = function()
            require('nvim_comment').setup()
        end
    }

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}

    use {
        "romgrk/barbar.nvim",

        config = function()
            vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>',
                                    {noremap = true, silent = true})
        end

    }

    use {"hrsh7th/vim-vsnip"}

    -- extras, these do not load by default

    -- Better motions
    use {
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('lv-hop').config()
        end,
        disable = not O.plugin.hop.active,
        opt = true
    }
    -- Enhanced increment/decrement
    use {
        'monaqa/dial.nvim',
        event = 'BufRead',
        config = function()
            require('lv-dial').config()
        end,
        disable = not O.plugin.dial.active,
        opt = true
    }
    -- Dashboard
    use {
        "ChristianChiarulli/dashboard-nvim",
        event = 'BufWinEnter',
        cmd = {"Dashboard", "DashboardNewFile", "DashboardJumpMarks"},
        config = function()
            require('lv-dashboard').config()
        end,
        disable = not O.plugin.dashboard.active,
        opt = true
    }
    -- Zen Mode
    -- use {
    --     "Pocco81/TrueZen.nvim",
    --     cmd = {"TZAtaraxis", "TZMinimalist"},
    --     config = function()
    --         require('lv-zen').config()
    --     end,
    --     disable = not O.plugin.zen.active,
    --     opt = true
    -- }

    -- -- matchup
    -- use {'andymass/vim-matchup', opt = true}
    -- require_plugin('vim-matchup')

    --     -- Snippets
    --     use {"rafamadriz/friendly-snippets", opt = true}
    --     require_plugin("friendly-snippets")

    --     -- Colorizer
    --     use {'norcalli/nvim-colorizer.lua', opt = true}
    --     require_plugin('nvim-colorizer.lua')

    --     -- Peek lines
    --     use {'nacro90/numb.nvim', opt = true}
    --     require_plugin('numb.nvim')
    -- 
    --     -- Treesitter playground
    --     use {'nvim-treesitter/playground', opt = true}
    --     require_plugin('playground')
    -- 
    -- 
    -- 
    --     -- Latex
    --     use {"lervag/vimtex", opt = true}
    --     require_plugin("vimtex")
    -- 
    --     -- comments in context
    --     use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}
    --     require_plugin("nvim-ts-context-commentstring")
    -- 
    -- 
    --     -- Git extras
    --     use {'f-person/git-blame.nvim', opt = true}
    --     require_plugin("git-blame.nvim")
    -- 
    -- 
    --     -- diagnostics
    --     use {"folke/trouble.nvim", opt = true}
    --     require_plugin('trouble.nvim')
    -- 
    --     -- Debugging
    --     use {"mfussenegger/nvim-dap", opt = true}
    --     require_plugin("nvim-dap")
    -- 
    -- 
    --     -- Better quickfix
    --     use {"kevinhwang91/nvim-bqf", opt = true}
    --     require_plugin("nvim-bqf")
    -- 
    --     -- Search & Replace
    --     use {'windwp/nvim-spectre', opt = true}
    --     require_plugin('nvim-spectre')
    -- 
    --     -- Symbol Outline
    --     use {'simrat39/symbols-outline.nvim', opt = true}
    --     require_plugin('symbols-outline.nvim')
    -- 
    --     -- Interactive scratchpad
    --     use {'metakirby5/codi.vim', opt = true}
    --     require_plugin('codi.vim')
    -- 
    --     -- Markdown preview
    --     use {
    --         'iamcco/markdown-preview.nvim',
    --         run = 'cd app && npm install',
    --         opt = true
    --     }
    --     require_plugin('markdown-preview.nvim')
    -- 
    --     -- Floating terminal
    --     use {'numToStr/FTerm.nvim', opt = true}
    --     require_plugin('FTerm.nvim')
    -- 
    --     -- Sane gx for netrw_gx bug
    --     use {"felipec/vim-sanegx", opt = true}

    -- lsp root
    -- use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
    -- require_plugin('lsp-rooter.nvim')

    -- Extras
    if O.extras then
        -- HTML preview
        use {
            'turbio/bracey.vim',
            run = 'npm install --prefix server',
            opt = true
        }
        require_plugin('bracey.vim')

        use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
        use {"nvim-telescope/telescope-project.nvim", opt = true}
        require_plugin('telescope-project.nvim')

        -- Autotag
        -- use {"windwp/nvim-ts-autotag", opt = true}
        -- require_plugin("nvim-ts-autotag")

        -- folke/todo-comments.nvim
        -- gennaro-tedesco/nvim-jqx
        -- TimUntersberger/neogit
        -- folke/lsp-colors.nvim
        -- simrat39/symbols-outline.nvim

        -- Git
        -- use {'tpope/vim-fugitive', opt = true}
        -- use {'tpope/vim-rhubarb', opt = true}
        -- pwntester/octo.nvim

        -- Easily Create Gists
        -- use {'mattn/vim-gist', opt = true}
        -- use {'mattn/webapi-vim', opt = true}
    end

end)
