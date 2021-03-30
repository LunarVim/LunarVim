local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'                                                    -- (lua) Vim Plugin manager

    -- Information
    use 'nanotee/nvim-lua-guide'                                                    -- (-) Adds Neovim Lua documentation to Noevim's help system.

    -- Quality of life improvements
    use 'norcalli/nvim_utils'                                                       -- (lua) Adds Neovim Lua shortcuts and extra functionality.

    -- LSP
    use 'glepnir/lspsaga.nvim'                                                      -- (lua) Extension to Neovim's LSP's user interface.
    use 'kabouzeid/nvim-lspinstall'                                                 -- (lua) Plugin to manage installation of language server protocol servers for various programming languages.
    use 'kosayoda/nvim-lightbulb'                                                   -- (lua) Shows a lightbulb on a line when a codeAction is available for it.
    use 'mfussenegger/nvim-jdtls'                                                   -- (lua) Neovim integration for Eclipse's JDTLS Java LSP server.
    use 'neovim/nvim-lspconfig'                                                     -- (lua) Configurations for various language's LSP servers.
    use 'onsails/lspkind-nvim'                                                      -- (lua) Adds icons for the kinds of LSP autocompletions in the completion menu.

    -- Debugging
    use 'mfussenegger/nvim-dap'                                                     -- (lua) Debug adapter protocol client implementation for Neovim for debugging many languages.

    -- Autocomplete
    use 'rafamadriz/friendly-snippets'                                              -- (-) A snippet collection for many different programming languages.
    use 'ChristianChiarulli/java-snippets'                                          -- (-) Java snippets
    use 'hrsh7th/nvim-compe'                                                        -- (vimscript) A completion plugin for Neovim with support for LSP completions.
    use 'hrsh7th/vim-vsnip'                                                         -- (vimscript) Adds support for VSCode style snippets. Means you can install and use snippets from VS Code snippet repos.
    use 'mattn/emmet-vim'                                                           -- (vimscript) Allows writing html using abbreviations that are then expanded.

    -- Treesitter
    use 'JoosepAlviste/nvim-ts-context-commentstring'                               -- (lua) Uses Treesitter to set the commentstring variable based on context. Good for embedded languages (e.g. html inside Javascript). Allows smarter commenting using nvim-comment.
    use 'nvim-treesitter/nvim-treesitter-refactor'                                  -- (lua) A refactor of Neovim Treesitter's Highlight definitions, Highlight current scope, Smart rename and Navigation features.
    use 'nvim-treesitter/playground'                                                -- (lua) View Treesitter information inside Neovim.
    use 'p00f/nvim-ts-rainbow'                                                      -- (lua) Rainbowification of braces using Treesitter. Good for identifying which brace pairs with which.
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}                      -- (lua) Treesitter integration for Neovim.

    -- Icons
    use 'kyazdani42/nvim-web-devicons'                                              -- (lua) Adds filetype icons to many other plugins.

    -- Status Line
    use 'glepnir/galaxyline.nvim'                                                   -- (lua) A very fast lua statusline plugin.

    -- Telescope
    if vim.fn.has("linux") then use 'nvim-telescope/telescope-media-files.nvim' end -- (lua) Allow previewing of media files inside Telescope (only works on Linux)
    use 'nvim-telescope/telescope.nvim'                                             -- (lua) a extendable fuzzy finder for searching over lists.

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'                                                  -- (lua) A file drawer
    use 'kevinhwang91/rnvimr'                                                       -- (vimscript) Neovim integration with ranger.

    -- Color
    use 'christianchiarulli/nvcode-color-schemes.vim'                               -- (vimscript) The nvcode Neovim colour schemes repository.
    use 'norcalli/nvim-colorizer.lua'                                               -- (lua) A plugin to allow previewing of html/css colour codes inside Neovim.
    use 'sheerun/vim-polyglot'                                                      -- (vimscript) Adds filetype plugins for syntax highlighting of many different filetypes.

    -- Git
    use 'TimUntersberger/neogit'                                                    -- (lua) Magit clone for Neovim that is geared toward the Vim philosophy.
    use 'f-person/git-blame.nvim'                                                   -- (lua) Shows Git blame text for highlighted lines as virtual text using Neovim LSP.
    use 'shumphrey/fugitive-gitlab.vim'                                             -- (vimscript) Adds Fugitive Gbrowse support for Gitlab repos.
    use 'tommcdo/vim-fubitive'                                                      -- (vimscript) Adds Fugitive Gbrowse support for Bitbucket repos.
    use 'tpope/vim-fugitive'                                                        -- (vimscript) Git integration for Neovim.
    use 'tpope/vim-rhubarb'                                                         -- (vimscript) Adds Fugitive Gbrowse support for GitHub repos.
    use {'lewis6991/gitsigns.nvim'}                                                 -- (lua) Adds gitsigns.
    use {'pwntester/octo.nvim'}                                                     -- (lua) Plugin to work with Github issues and PRs from inside Neovim.

    -- Easily Create Gists
    use 'mattn/vim-gist'                                                            -- (vimscript) A vimscript plugin for creating Github gists.
    use 'mattn/webapi-vim'                                                          -- (vimscript) A plugin for working with webapi's using vimscript. Dependency of vim-gist.

    -- Webdev
    use 'gennaro-tedesco/nvim-jqx'                                                  -- (lua) A plugin to enable easier navigation of JSON files. Require 'jq'.
    use 'turbio/bracey.vim'                                                         -- (vimscript) A plugin for live HTML, Javascript and CSS editing.
    use 'windwp/nvim-ts-autotag'                                                    -- (lua) Plugin for automatically closing and renaming html tags. Uses Treesitter.

    -- Language / Library specific
    use 'thosakwe/vim-flutter'                                                      -- (lua) Vim commands for Flutter including hot reload on save and more.

    -- Registers
    use 'gennaro-tedesco/nvim-peekup'                                               -- (lua) Adds menu for viewing registers and selecting registers to use when pasting. Mapped to ""

    -- Navigation
    use 'phaazon/hop.nvim'                                                          -- (lua) Adds motions that can be used to 'hop' to locations within the file. HopWord 's' and 'S'
    use 'unblevable/quick-scope'                                                    -- (vimscript) Provides an overlay when using the 'f', 'F', 't' and 'T' motions to help with jumping to characters.

    -- General Plugins
    if O.dashboard == "dashboard" then use 'ChristianChiarulli/dashboard-nvim' end  -- (vimscript) A startup dashboard to enable easily opening previously used files using telescope.
    if O.dashboard == "startify" then use 'mhinz/vim-startify' end                  -- (vimscript) Adds a startup dashboard that allows quickly opening previously opened files.
    use 'windwp/nvim-autopairs'                                                     -- (lua) automatically create closing brackets/tags
    use 'MattesGroeger/vim-bookmarks'                                               -- (vimscript) This vim plugin allows toggling bookmarks per line. A quickfix window gives access to all bookmarks. Annotations can be added as well. These are special bookmarks with a comment attached.
    use 'airblade/vim-rooter'                                                       -- (vimscript) Ensures that the current working directory is the git root
    use 'andymass/vim-matchup'                                                      -- (vimscript) extends vim's % key to language-specific words instead of just single characters.
    use 'bfredl/nvim-miniyank'                                                      -- (vimscript) The killring-alike plugin with no default mappings.
    use 'brooth/far.vim'                                                            -- (vimscript) makes it easier to find and replace text through multiple files.
    use 'cohama/lexima.vim'                                                         -- (vimscript) Auto close parentheses and repeat by dot dot dot...
    use 'junegunn/goyo.vim'                                                         -- (vimscript) Focus mode to eliminate distractions when writing.
    use 'kevinhwang91/nvim-bqf'                                                     -- (lua) A plugin that enhances the quickfix window with Fuzzy Finding.
    use 'kshenoy/vim-signature'                                                     -- (vimscript) Adds mark characters in the gutter.
    use 'liuchengxu/vim-which-key'                                                  -- (vimscript) Displays a mapping cheat sheet for leader.
    use 'liuchengxu/vista.vim'                                                      -- (vimscript) LSP search for symbols and tags
    use 'machakann/vim-sandwich'                                                    -- (vimscript) Adds operators and mappings for adding / deleting / changing surrounding text.
    use 'metakirby5/codi.vim'                                                       -- (vimscript) A scratch pad interpretter for many languages.
    use 'moll/vim-bbye'                                                             -- (vimscript) Allows removing / deleting buffers without closing their windows.
    use 'monaqa/dial.nvim'                                                          -- (lua) Upgrades Ctrl-a and Ctrl-x to increment dates, alphabet and other types in addition to just numbers
    use 'nvim-lua/plenary.nvim'                                                     -- (lua) A library of Lua code used by many Neovim lua plugins.
    use 'nvim-lua/popup.nvim'                                                       -- (lua) A implementation of the Vim popup API in Neovim. Dependency of telescope.
    use 'psliwka/vim-smoothie'                                                      -- (vimscript) Makes scrolling in Vim smooth (adds a scrolling animation)
    use 'terrortylor/nvim-comment'                                                  -- (lua) Adds commands and mappings for commenting and uncommenting lines of code using the language's comment string.
    use 'tpope/vim-unimpaired'                                                      -- (vimscript) Adds many common sense mappings for working with buffers, quickfix, lines, SCM conflict markers, etc
    use 'vim-scripts/Align'                                                         -- (vimscript) Allows aligning sections of text (for example these comments in this plugin file (use visual to select the text and do :Align -- <CR>))
    use 'voldikss/vim-floaterm'                                                     -- (vimscript) Allows opening terminal's using Nvim's floating windows.
    use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](1) end}  -- (vimscript) Allows using Neovim to edit input boxes in browsers via a browser plugin.
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}             -- (vimscript) Allow previewing markdown with syncronised scrolling in a browser.
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}                     -- (vimscript) Adds indentline indentation lines to blank lines in addition to lines with code on.
end)
