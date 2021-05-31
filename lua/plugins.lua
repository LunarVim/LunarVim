local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
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

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

        -- LSP
        use {"neovim/nvim-lspconfig"}
        use {"glepnir/lspsaga.nvim", cmd = "Lspsaga", requires = {"neovim/nvim-lspconfig"}}
        use {"kabouzeid/nvim-lspinstall", 
            cmd = "LspInstall",
            config = function ()
              require('lv-lspinstall')
            end }

        -- Telescope
        use {"nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            module = {"plenary.nvim", "popup.nvim"},
            config = function() require("lv-telescope") end,
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzy-native.nvim"},
                {"nvim-telescope/telescope-project.nvim"},
            } }
        use  {"folke/trouble.nvim",
                cmd = {"Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh"},
                ft = "dashboard",
                event = {"BufEnter"},
                requires = "kyazdani42/nvim-web-devicons" }

        -- Debugging
        use {"mfussenegger/nvim-dap", opt = true}

        -- Autocomplete
        use {"hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function() require("lv-compe") end}
        use {"hrsh7th/vim-vsnip", after = "nvim-compe"}
        use {"rafamadriz/friendly-snippets", after = "nvim-compe"}

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
        use {"windwp/nvim-ts-autotag",
            ft = {  'html', 'javascript', 'javascriptreact', 
            'typescriptreact', 'svelte', 'vue'},
            config = function()
                        require('nvim-ts-autotag').setup()
                     end
            }
        use {"andymass/vim-matchup", keys = "%"}

        -- Explorer
        use {"kyazdani42/nvim-tree.lua",
            cmd = {"NvimTreeToggle","NvimTreeRefresh", "NvimTreeFindFile"},
            event = {"BufEnter"},
            config = function() require('lv-nvimtree') end,
            requires = {"kyazdani42/nvim-web-devicons"}}
        use {"ahmedkhalf/lsp-rooter.nvim", after = "nvim-tree.lua"} -- with this nvim-tree will follow you        
        -- TODO remove when open on dir is supported by nvimtree
        use {"kevinhwang91/rnvimr", config = function() require('lv-rnvimr') end}

        -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
        use {"lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            config = function() require("lv-gitsigns") end}
        use {'f-person/git-blame.nvim',
            cmd = "GitBlameToggle",
            config = function() require("lv-gitblame") end}
        use {"folke/which-key.nvim",
            event = {"BufEnter", "BufReadPost"},
            ft = {"dashboard"},
            config = function() require('lv-which-key') end}
        use {"ChristianChiarulli/dashboard-nvim",
            event = "BufEnter",
            config = function() require('lv-dashboard') end }
        use {"windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function() require("lv-autopairs") end,
            requires = {"nvim-treesitter/nvim-treesitter"}}
        use {"kevinhwang91/nvim-bqf", event = "QuickFixCmdPre"}

        -- Comments
        use {"terrortylor/nvim-comment",
            cmd = "CommentToggle",
            keys ="gcc",
            config = function() require("lv-comment") end}
        use {'JoosepAlviste/nvim-ts-context-commentstring',
            event = "BufReadPost",
            requires = "nvim-treesitter"}

        -- Color
        use {"christianchiarulli/nvcode-color-schemes.vim",
            event = "BufEnter",
            config = function() require('colorscheme')end}

        -- Status Line and Bufferline
        use {"glepnir/galaxyline.nvim",
            event = "BufEnter",
            config = function() require("lv-galaxyline") end}
        use {"romgrk/barbar.nvim",
            event = "BufEnter",
            config = function() require("lv-barbar") end,
            requires = {"kyazdani42/nvim-web-devicons"}}

        -- Zen Mode
        use {"Pocco81/TrueZen.nvim",
            cmd = {"TZMinimalist", "TZFocus", "TZAtaraxis"},
            config = function() require('lv-zen') end}

        require_plugin("nvim-dap")

        -- Extras
        if O.extras then
            use {'metakirby5/codi.vim', opt = true}
            require_plugin('codi.vim')
            use {'iamcco/markdown-preview.nvim', 
                run = 'cd app && npm install',
             -- run = 'call mkdp#util#install()', -- use this line if the above doesn't work for you
                ft = "markdown" }
            use {'numToStr/FTerm.nvim', opt = true}
            require_plugin('numToStr/FTerm.nvim')
            use {'monaqa/dial.nvim', opt = true}
            require_plugin('dial.nvim')
            use {'nacro90/numb.nvim', opt = true}
            require_plugin('numb.nvim')
            use {'turbio/bracey.vim', opt = true}
            require_plugin('bracey.vim')
            use {'phaazon/hop.nvim', opt = true}
            require_plugin('hop.nvim')
            use {'norcalli/nvim-colorizer.lua', opt = true}
            require_plugin('nvim-colorizer.lua')
            use {'windwp/nvim-spectre', opt = true}
            require_plugin('windwp/nvim-spectre')
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
end
)
