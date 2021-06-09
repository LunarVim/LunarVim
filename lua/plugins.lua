local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local plugin_count = 1
local load_index = {}
local load_list = {}

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

local function use_maker(use)
    local function file_exists(name)
        local f = io.open(name, "r")
        if f ~= nil then
            io.close(f)
            return true
        else
            return false
        end
    end

    local function split(str, sep)
        if sep == nil then sep = '%s' end

        local res = {}
        local func = function(w)
            table.insert(res, w)
        end

        string.gsub(str, '[^' .. sep .. ']+', func)
        return res
    end

    return function(plugin_settings)
        if type(plugin_settings) ~= 'table' then plugin_settings = {plugin_settings} end
        local plugin_name = split(plugin_settings[1], '/')[2]
        local config_dir = 'lv-' .. split(plugin_name, '.')[1]
        local dir_path = fn.stdpath('config') .. '/lua/'

        local configured = file_exists(dir_path .. config_dir .. '/init.lua')
        local lazy = plugin_settings.opt and plugin_settings.opt or true
        load_index[plugin_count] = plugin_name
        plugin_count = plugin_count + 1
        if configured then
            load_list[plugin_name] = {config_dir, lazy}
        else
            load_list[plugin_name] = {false, lazy}
        end
        use(plugin_settings)
    end
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

local packer = require("packer")
packer.startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    local Use = use_maker(use)

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    Use {"neovim/nvim-lspconfig", opt = true}
    Use {"glepnir/lspsaga.nvim", opt = true}
    Use {"kabouzeid/nvim-lspinstall", opt = true}
    Use {"folke/trouble.nvim", opt = true}

    -- Telescope
    Use {"nvim-lua/popup.nvim", opt = true}
    Use {"nvim-lua/plenary.nvim", opt = true}
    Use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
    Use {"nvim-telescope/telescope-project.nvim", opt = true}
    Use {"nvim-telescope/telescope.nvim", opt = true}

    -- Debugging
    Use {"mfussenegger/nvim-dap", opt = true}

    -- Autocomplete
    Use {"hrsh7th/nvim-compe", opt = true}
    Use {"hrsh7th/vim-vsnip", opt = true}
    Use {"rafamadriz/friendly-snippets", opt = true}

    -- Treesitter
    Use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    Use {"windwp/nvim-ts-autotag", opt = true}
    Use {'andymass/vim-matchup', opt = true}

    -- Explorer
    Use {"kyazdani42/nvim-tree.lua", opt = true}
    Use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
    -- TODO remove when open on dir is supported by nvimtree
    Use "kevinhwang91/rnvimr"

    -- Use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    Use {"lewis6991/gitsigns.nvim", opt = true}
    Use {'f-person/git-blame.nvim', opt = true}
    Use {"folke/which-key.nvim", opt = true}
    Use {"ChristianChiarulli/dashboard-nvim", opt = true}
    Use {"windwp/nvim-autopairs", opt = true}
    Use {"kevinhwang91/nvim-bqf", opt = true}

    -- Comments
    Use {"terrortylor/nvim-comment", opt = true}
    Use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}

    -- Color
    Use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    Use {"kyazdani42/nvim-web-devicons", opt = true}

    -- Status Line and Bufferline
    Use {"glepnir/galaxyline.nvim", opt = true}
    Use {"romgrk/barbar.nvim", opt = true}

    -- Zen Mode
    Use {"Pocco81/TrueZen.nvim", opt = true}

    -- Extras
    if O.extras then
        Use {'metakirby5/codi.vim', opt = true}
        Use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', opt = true}
        Use {'numToStr/FTerm.nvim', opt = true}
        Use {'monaqa/dial.nvim', opt = true}
        Use {'nacro90/numb.nvim', opt = true}
        Use {'turbio/bracey.vim', run = 'npm install --prefix server', opt = true}
        Use {'phaazon/hop.nvim', opt = true}
        Use {'norcalli/nvim-colorizer.lua', opt = true}
        Use {'windwp/nvim-spectre', opt = true}
        Use {'simrat39/symbols-outline.nvim', opt = true}
        Use {'nvim-treesitter/playground', opt = true}
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

for i, plugin_name in pairs(load_index) do
    if load_list[plugin_name][2] then require_plugin(plugin_name) end
    if load_list[plugin_name][1] then require(load_list[plugin_name][1]) end
end
