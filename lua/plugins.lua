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
    use {"glepnir/lspsaga.nvim", opt = true}
    use {"kabouzeid/nvim-lspinstall", opt = true}
    use {"folke/trouble.nvim", opt = true}

    -- Telescope
    use {"nvim-lua/popup.nvim", opt = true}
    use {"nvim-lua/plenary.nvim", opt = true}
    use {"nvim-telescope/telescope.nvim", opt = true}
    use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    use {"nvim-telescope/telescope-project.nvim", opt = true}

    -- Debugging
    use {"mfussenegger/nvim-dap", opt = true}

    -- Autocomplete
    use {"hrsh7th/nvim-compe", opt = true}
    use {"hrsh7th/vim-vsnip", opt = true}
    use {"rafamadriz/friendly-snippets", opt = true}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"windwp/nvim-ts-autotag", opt = true}
    use {'andymass/vim-matchup', opt = true}

    -- Explorer
    use {"kyazdani42/nvim-tree.lua", opt = true}
    use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
    -- TODO remove when open on dir is supported by nvimtree
    use "kevinhwang91/rnvimr"

    -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    use {"lewis6991/gitsigns.nvim", opt = true}
    use {'f-person/git-blame.nvim', opt = true}
    use {"folke/which-key.nvim", opt = true}
    use {"ChristianChiarulli/dashboard-nvim", opt = true}
    use {"windwp/nvim-autopairs", opt = true}
    use {"kevinhwang91/nvim-bqf", opt = true}

    -- Comments
    use {"terrortylor/nvim-comment", opt = true}
    use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons", opt = true}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim", opt = true}
    use {"romgrk/barbar.nvim", opt = true}

    -- Zen Mode
    use {"Pocco81/TrueZen.nvim", opt = true}

    require_plugin("nvim-lspconfig")
    require_plugin("lspsaga.nvim")
    require_plugin("nvim-lspinstall")
    require_plugin('trouble.nvim')
    require_plugin("friendly-snippets")
    require_plugin("popup.nvim")
    require_plugin("plenary.nvim")
    require_plugin("telescope.nvim")
    require_plugin('telescope-project.nvim')
    require_plugin("nvim-dap")
    require_plugin("nvim-compe")
    require_plugin("vim-vsnip")
    require_plugin("nvim-treesitter")
    require_plugin("nvim-ts-autotag")
    require_plugin('vim-matchup')
    require_plugin("nvim-tree.lua")
    require_plugin("gitsigns.nvim")
    require_plugin("git-blame.nvim")
    require_plugin("which-key.nvim")
    require_plugin("dashboard-nvim")
    require_plugin("nvim-autopairs")
    require_plugin("nvim-comment")
    require_plugin("nvim-bqf")
    require_plugin("nvcode-color-schemes.vim")
    require_plugin("nvim-web-devicons")
    require_plugin("galaxyline.nvim")
    require_plugin("barbar.nvim")
    require_plugin('lsp-rooter.nvim')
    require_plugin("TrueZen.nvim")
    require_plugin("nvim-ts-context-commentstring")

    -- Extras
    if O.extras then
        use {'metakirby5/codi.vim', opt = true}
        require_plugin('codi.vim')
        use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', opt = true}
        require_plugin('markdown-preview.nvim')
        use {'numToStr/FTerm.nvim', opt = true}
        require_plugin('numToStr/FTerm.nvim')
        use {'monaqa/dial.nvim', opt = true}
        require_plugin('dial.nvim')
        use {'nacro90/numb.nvim', opt = true}
        require_plugin('numb.nvim')
        use {'turbio/bracey.vim', run = 'npm install --prefix server', opt = true}
        require_plugin('bracey.vim')
        use {'phaazon/hop.nvim', opt = true}
        require_plugin('hop.nvim')
        use {'norcalli/nvim-colorizer.lua', opt = true}
        require_plugin('nvim-colorizer.lua')
        use {'windwp/nvim-spectre', opt = true}
        require_plugin('windwp/nvim-spectre')
        use {'simrat39/symbols-outline.nvim', opt = true}
        require_plugin('symbols-outline.nvim')
        use {'nvim-treesitter/playground', opt = true}
        require_plugin('playground')
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
