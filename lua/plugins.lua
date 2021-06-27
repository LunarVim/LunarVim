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

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig", opt = true}
    use {"kabouzeid/nvim-lspinstall", opt = true}
    -- Telescope
    use {"nvim-lua/popup.nvim", opt = true}
    use {"nvim-lua/plenary.nvim", opt = true}
    use {"nvim-telescope/telescope.nvim", opt = true}

    -- Autocomplete
    use {"hrsh7th/nvim-compe", event = "InsertEnter", opt = true}

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        -- event = "BufRead"

         run = ":TSUpdate"

    }

    -- Explorer
    -- use {"kyazdani42/nvim-tree.lua", opt = true}

    use {"kyazdani42/nvim-tree.lua", opt = true, cmd = "NvimTreeToggle", config = require_plugin("nvim-tree.lua")}

    -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    use {"lewis6991/gitsigns.nvim", config = require_plugin("gitsigns.nvim"), event = "BufRead", opt = true}

    use {"folke/which-key.nvim", config = require_plugin("which-key.nvim"), opt = true}
    use {"windwp/nvim-autopairs", config = require_plugin("nvim-autopairs"), event = "InsertEnter", opt = true}

    -- Comments
    use {"terrortylor/nvim-comment", config = require_plugin("nvim-comment"), opt = true}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", config = require_plugin("nvcode-color-schemes.vim"), opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons", config = require_plugin("nvim-web-devicons"), opt = true}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim", config = require_plugin("galaxyline.nvim"), opt = true}
    use {"romgrk/barbar.nvim", config = require_plugin("barbar.nvim"), opt = true}

    use {"hrsh7th/vim-vsnip", config = require_plugin("vim-vsnip"), opt = true}

    require_plugin("nvim-lspconfig")
    require_plugin("nvim-lspinstall")
    require_plugin("popup.nvim")
    require_plugin("plenary.nvim")
    require_plugin("telescope.nvim")
    require_plugin("nvim-compe")
    require_plugin("nvim-treesitter")


    -- Extras
    if O.extras then
        -- Interactive scratchpad
        use {'metakirby5/codi.vim', opt = true}
        require_plugin('codi.vim')
        -- Markdown preview
        use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', opt = true}
        require_plugin('markdown-preview.nvim')
        -- Floating terminal
        use {'numToStr/FTerm.nvim', opt = true}
        require_plugin('FTerm.nvim')
        -- Enhanced increment/decrement
        use {'monaqa/dial.nvim', opt = true}
        require_plugin('dial.nvim')
        -- Peek lines
        use {'nacro90/numb.nvim', opt = true}
        require_plugin('numb.nvim')
        -- HTML preview
        use {'turbio/bracey.vim', run = 'npm install --prefix server', opt = true}
        require_plugin('bracey.vim')
        -- Better motions
        use {'phaazon/hop.nvim', opt = true}
        require_plugin('hop.nvim')
        -- Colorizer
        use {'norcalli/nvim-colorizer.lua', opt = true}
        require_plugin('nvim-colorizer.lua')
        -- Search & Replace
        use {'windwp/nvim-spectre', opt = true}
        require_plugin('nvim-spectre')
        use {'simrat39/symbols-outline.nvim', opt = true}
        require_plugin('symbols-outline.nvim')
        -- Treesitter playground
        use {'nvim-treesitter/playground', opt = true}
        require_plugin('playground')
        -- Latex
        use {"lervag/vimtex", opt = true}
        require_plugin("vimtex")
        -- matchup
        use {'andymass/vim-matchup', opt = true}
        require_plugin('vim-matchup')
        -- comments in context
        use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}
        require_plugin("nvim-ts-context-commentstring")
        -- Zen Mode
        use {"Pocco81/TrueZen.nvim", opt = true}
        require_plugin("TrueZen.nvim")
        -- Git extras
        use {'f-person/git-blame.nvim', opt = true}
        require_plugin("git-blame.nvim")
        -- TODO remove when open on dir is supported by nvimtree
        --  use "kevinhwang91/rnvimr"
        use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
        use {"nvim-telescope/telescope-project.nvim", opt = true}
        require_plugin('telescope-project.nvim')

        -- Debugging
        use {"mfussenegger/nvim-dap", opt = true}
        require_plugin("nvim-dap")

        use {"rafamadriz/friendly-snippets", opt = true}
        require_plugin("friendly-snippets")

        use {"kevinhwang91/nvim-bqf", opt = true}
        require_plugin("nvim-bqf")

        use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
        require_plugin('lsp-rooter.nvim')

        use {"glepnir/lspsaga.nvim", opt = true}
        require_plugin("lspsaga.nvim")

        use {"ChristianChiarulli/dashboard-nvim", opt = true}
        require_plugin("dashboard-nvim")

        use {"folke/trouble.nvim", opt = true}
        require_plugin('trouble.nvim')

        -- Sane gx for netrw_gx bug
        use {"felipec/vim-sanegx", opt = true}
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
