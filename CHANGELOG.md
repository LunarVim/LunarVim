# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### <!-- 1 --> Features

- _(cmp)_ documentation is deprecated in favor of window.documentation ([#2461](https://github.com/lunarvim/lunarvim/pull/2461))
- _(cmp)_ add option to disable friendly-snippets ([#2660](https://github.com/lunarvim/lunarvim/pull/2660))
- _(codelens)_ cursorhold is too much intrusive for codelens ([#2600](https://github.com/lunarvim/lunarvim/pull/2600))
- _(icons)_ make it possible to disable icons ([#2529](https://github.com/lunarvim/lunarvim/pull/2529))
- _(installer)_ ensure correct responses when prompting user ([#2506](https://github.com/lunarvim/lunarvim/pull/2506))
- _(installer)_ add verify-plugins hook ([#2751](https://github.com/lunarvim/lunarvim/pull/2751))
- _(lsp)_ add option to override default `nvim-lsp-installer` settings ([#2698](https://github.com/lunarvim/lunarvim/pull/2698))
- _(lsp)_ add option to override nlsp-settings ([#2769](https://github.com/lunarvim/lunarvim/pull/2769))
- _(lsp)_ bind formatexpr and omnifunc by default ([#2865](https://github.com/lunarvim/lunarvim/pull/2865))
- _(lua-dev)_ use the newer lua-dev branch till folke comes back ([#2538](https://github.com/lunarvim/lunarvim/pull/2538))
- _(neovim)_ neovim 0.8 compatibility ([#2544](https://github.com/lunarvim/lunarvim/pull/2544))
- _(peek)_ make sure max width and height are customizable ([#2492](https://github.com/lunarvim/lunarvim/pull/2492))
- _(plugins)_ add support for packer snapshots ([#2351](https://github.com/lunarvim/lunarvim/pull/2351))
- _(quit)_ make sure to ask before discarding changes ([#2554](https://github.com/lunarvim/lunarvim/pull/2554))
- _(which-key)_ added search command for colour highlights ([#2693](https://github.com/lunarvim/lunarvim/pull/2693))
- lock nvim <0.7 to a specific tag ([#2491](https://github.com/lunarvim/lunarvim/pull/2491))
- gitsigns yadm support ([#2535](https://github.com/lunarvim/lunarvim/pull/2535))
- add cmp-tmux to the list of sources ([#2542](https://github.com/lunarvim/lunarvim/pull/2542))
- prompt when closing modified/term buffers ([#2658](https://github.com/lunarvim/lunarvim/pull/2658))
- fix a couple of issues ([#2750](https://github.com/lunarvim/lunarvim/pull/2750))
- add commands to open/edit lvim logs ([#2709](https://github.com/lunarvim/lunarvim/pull/2709))

### <!-- 2 --> Bugfix

- _(autocmd)_ actually use the format wrapper ([#2560](https://github.com/lunarvim/lunarvim/pull/2560))
- _(autocmds)_ make sure we are using codelens correctly ([#2576](https://github.com/lunarvim/lunarvim/pull/2576))
- _(autocmds)_ disable commentstring_calc on cursor-hold ([#2581](https://github.com/lunarvim/lunarvim/pull/2581))
- _(autocmds)_ toggle format-on-save properly ([#2659](https://github.com/lunarvim/lunarvim/pull/2659))
- _(cmp)_ update nvim-cmp to the latest version ([#2467](https://github.com/lunarvim/lunarvim/pull/2467))
- _(cmp)_ hotfix nvim-cmp version
- _(cmp)_ bring back default keybindings ([#2470](https://github.com/lunarvim/lunarvim/pull/2470))
- _(cmp)_ update nvim-cmp to the latest version ([#2467](https://github.com/lunarvim/lunarvim/pull/2467)) ([#2469](https://github.com/lunarvim/lunarvim/pull/2469))
- _(core.comment)_ fix default extra mappings ([#2768](https://github.com/lunarvim/lunarvim/pull/2768))
- _(dap)_ temporarily use dap-buddy dev branch which has older code ([#2567](https://github.com/lunarvim/lunarvim/pull/2567))
- _(dap)_ pause key binding commmand ([#2573](https://github.com/lunarvim/lunarvim/pull/2573))
- _(impatient)_ avoid get_options in fast handler ([#2451](https://github.com/lunarvim/lunarvim/pull/2451))
- _(installer)_ latest and specified release version for neovim have different urls ([#2484](https://github.com/lunarvim/lunarvim/pull/2484))
- _(installer)_ use full path to verify_plugins.lua ([#2755](https://github.com/lunarvim/lunarvim/pull/2755))
- _(installer)_ always use check shallow clones ([#2763](https://github.com/lunarvim/lunarvim/pull/2763))
- _(installer/pwsh)_ fixes some details on installer and uninstaller ([#2404](https://github.com/lunarvim/lunarvim/pull/2404))
- _(log)_ add date to the timestamp of logs ([#2669](https://github.com/lunarvim/lunarvim/pull/2669))
- _(lsp)_ undo stdpath overload to avoid datarace ([#2540](https://github.com/lunarvim/lunarvim/pull/2540))
- _(lsp)_ update format filter for nightly ([#2773](https://github.com/lunarvim/lunarvim/pull/2773))
- _(lualine)_ color theme gaps in some components ([#2465](https://github.com/lunarvim/lunarvim/pull/2465))
- _(lualine)_ unique buf client names ([#2683](https://github.com/lunarvim/lunarvim/pull/2683))
- _(luasnip)_ make sure all snippets are loaded ([#2447](https://github.com/lunarvim/lunarvim/pull/2447))
- _(luasnip)_ only use user snippets if the folder exists ([#2481](https://github.com/lunarvim/lunarvim/pull/2481))
- _(nvimtree)_ escape the dot character in custom filter ([#2493](https://github.com/lunarvim/lunarvim/pull/2493))
- _(nvimtree)_ make sure on_config_done is using the correct require ([#2509](https://github.com/lunarvim/lunarvim/pull/2509))
- _(nvimtree)_ add latest changes from nvimtree ([#2537](https://github.com/lunarvim/lunarvim/pull/2537))
- _(nvimtree)_ update nvim-tree setup ([#2681](https://github.com/lunarvim/lunarvim/pull/2681))
- _(packer)_ add max_jobs = 40 ([#2781](https://github.com/lunarvim/lunarvim/pull/2781))
- _(readme)_ update lsp server ignore syntax
- _(readme)_ remove black as linter ([#2510](https://github.com/lunarvim/lunarvim/pull/2510))
- _(telescope)_ set <cr> binding to actions.select_default only ([#2395](https://github.com/lunarvim/lunarvim/pull/2395))
- _(theme)_ make sure the new theme is fully loaded ([#2392](https://github.com/lunarvim/lunarvim/pull/2392))
- _(windows)_ specify required powershell version for the installation script ([#2376](https://github.com/lunarvim/lunarvim/pull/2376))
- update deprecated methods in example configuration for trouble.nvim ([#2416](https://github.com/lunarvim/lunarvim/pull/2416))
- use correct cache path ([#2593](https://github.com/lunarvim/lunarvim/pull/2593))
- load notify's telescope extension properly ([#2586](https://github.com/lunarvim/lunarvim/pull/2586))
- skip calling nvim-tree.setup() more than once ([#2707](https://github.com/lunarvim/lunarvim/pull/2707))
- typo in utils/installer/install.sh ([#2776](https://github.com/lunarvim/lunarvim/pull/2776))

### <!-- 3 --> Refactor

- _(lsp)_ replace deprecated ocamllsp with ocamlls ([#2402](https://github.com/lunarvim/lunarvim/pull/2402))
- _(lsp)_ cleanup servers' override configuration ([#2243](https://github.com/lunarvim/lunarvim/pull/2243))
- _(lsp)_ decouple the installer setup-hook ([#2536](https://github.com/lunarvim/lunarvim/pull/2536))
- _(telescope)_ don't overwrite default cmd to show hidden files
- _(whichkey)_ use vim.keymap.set directly ([#2786](https://github.com/lunarvim/lunarvim/pull/2786))
- re-enable packer.sync() in LvimReload ([#2410](https://github.com/lunarvim/lunarvim/pull/2410))
- update impatient ([#2477](https://github.com/lunarvim/lunarvim/pull/2477))
- lock new installations to nvim v0.7+ ([#2526](https://github.com/lunarvim/lunarvim/pull/2526))
- use api-autocmds for lsp functions ([#2549](https://github.com/lunarvim/lunarvim/pull/2549))
- [**breaking**] load the default options once ([#2592](https://github.com/lunarvim/lunarvim/pull/2592))
- remove redundant ftdetects ([#2651](https://github.com/lunarvim/lunarvim/pull/2651))

### <!-- 4 --> Documentation

- _(README)_ change forgotten breaking change in example ([#2377](https://github.com/lunarvim/lunarvim/pull/2377))
- _(windows)_ use alpha in config_win.example.lua ([#2452](https://github.com/lunarvim/lunarvim/pull/2452))

### <!-- 5 --> Revert

- do not run packer.sync() on every reload ([#2548](https://github.com/lunarvim/lunarvim/pull/2548))

## [1.1.3]

### <!-- 1 --> Features

- add alpha.nvim integration (#1906)

### <!-- 2 --> Bugfix

- _(alpha)_ globalstatus after openning files from dashboard (#2366)
- _(bufferline)_ add an additional space before diagnostics (#2367)
- _(lualine)_ conditional theme loading (#2363)
- _(peek)_ make sure popup_options are positive (#2373)
- _(peek)_ print error if lsp is unable to get file contents (#2379)
- _(terminal)_ whichkey -> which-key (#2380)
- _(terminal)_ weird lazygit commit message bug (#2382)
- _(windows)_ use correct validation for the alias (#2371)
- nvim-tree taking half the window on open (#2357)
- correct typo in backup function (#2358)
- automatically set colorscheme (#2370)

### <!-- 3 --> Refactor

- load onedarker theme externally (#2359)

### <!-- 4 --> Documentation

- update demo images on the main readme (#2386)

## [1.1.2]

### <!-- 1 --> Features

- _(installer)_ Use pnpm to install nodejs dependencies(#2279) (#2280)
- _(windows)_ Add custom config_win.example.lua (#2330)
- Add option to automatically answer 'yes' for sh install script (#2306)
- Enable nlsp-settings schemas (#2322)

### <!-- 2 --> Bugfix

- _(nlsp-settings)_ Cross platform issue (#2335)
- _(timeoutlen)_ This has caused way too many issues in the past (#2287)
- Disable the default intro message (#2340)

### <!-- 3 --> Refactor

- _(nvim-tree)_ Update settings structure (#2304)

### <!-- 4 --> Documentation

- _(readme)_ Fix typo in example config (#2333)

## [1.1.1]

### <!-- 2 --> Bugfix

- Add tsx to treesitter ensure_installed list (#2268)
- Correct a path to bufferline module (#2270)

## [1.1.0]

### <!-- 1 --> Features

- _(vue)_ Set volar as default language server instead of vuels (#2230)
- Use schemastore.nvim to provide extended json schema support (#2239)
- Use bufferline instead of barbar (#2254)
- Add a minimal implementation of bbye (#2267)

### <!-- 2 --> Bugfix

- _(autopairs)_ Remove weird tex rules from autopairs (#2206)
- _(diag)_ Show lsp-diag code in open_float (#2180)
- _(installer)_ Usernames can contain @ symbol (#2167)
- _(installer)_ Universal bash (#2241)
- _(logging)_ Disable insane amount of logging inside lvim.log (#2205)
- _(lsp)_ No need to stop clients on LvimReload (#2160)
- _(lsp)_ Use temporary fork of lua-dev (#2187)
- _(lsp)_ Avoid accessing undefined user_data (#2216)
- _(lualine)_ Add space to diff components (#1897)
- _(lualine)_ Compacter size for treesitter icon (#2247)
- _(lualine)_ Use 1-char width symbol for changed (#2246)
- _(which-key)_ The PR has been merged to the original repo (#2172)
- _(zsh)_ Don't set filetype to sh (#2035)
- Added -ScriptBlock to run commands ```install.ps1``` (#2188)

### <!-- 3 --> Refactor

- _(nvim-tree)_ Cleanup and update settings (#2182)
- _(nvim-tree)_ Remove unused code (#2266)
- Remove unused outdated files (#2184)

### <!-- 4 --> Documentation

- _(readme)_ Add powershell installer script for Windows (#2208)

## [1.0.0]

### <!-- 1 --> Features

- _(info)_ Display overridden servers for filetype (#2155)
- _(luadev)_ Better vim api completion (#2043)
- Add lualine config for darkplus
- Last updates before 1.0.0 (#1953)
- Use Telescope's git_files with fallback (#2089)
- Plugin version bump (#2120)
- Lazyload notify's configuration (#1855)
- Plugin version bump (#2131)

### <!-- 2 --> Bugfix

- _(gitsigns)_ Rounded border (#2142)
- _(install)_ Avoid data-races for `on_packer_complete` (#2157)
- _(installer)_ Backup linked files with rsync (#2081)
- _(installer)_ Check if npm-prefix is writable (#2091)
- _(installer)_ More robust yarn validation (#2113)
- _(lsp)_ Set the handlers opts for v0.6 as well (#2109)
- _(lsp)_ Formatter now use new null-ls api function (#2135)
- _(lsp)_ Formatter now use new null-ls api function (#2135)
- _(null-ls)_ Avoid sending invalid opts.args (#2154)
- _(which-key)_ Temporary solution for which-key (#2150)
- Remove autopairs cmp completion (#2083)
- Remove "error" message from git tag (#2141)

### <!-- 3 --> Refactor

- _(bootstrap)_ More robust git module (#2127)
- _(info)_ Use new null-ls api for sources (#2125)
- _(install.sh)_ Fix typo in node error message (#2107)
- _(null-ls)_ Allow passing full list of options for sources (#2137)
- _(settings)_ Add headless-mode settings (#2134)
- _(term)_ Leave the first few ids unassigned (#2156)
- _(test)_ Cleanup test utilities (#2132)
- Deprecate lvim.lang.FOO (#1913) (#1914)
- Remove unused old language configs (#2094)
- Uplift neovim's minimum version requirement to 0.6.0 (#2093)
- Avoid running ts.setup in headless (#2119)
- More consistent autocmds (#2133)
- Use a static lvim binary template (#1444)

## [1.0.0-rc]

### <!-- 1 --> Features

- _(installer)_ Nicer rsync output (#2067)
- _(terminal)_ Lazygit can now be toggled (#2039)
- Add lualine config for darkplus
- Last updates before 1.0.0 (#1953)
- Support new null-ls (#1955)
- Empty for empty buffers instead of Buffer <#>
- Improved LSP grouping in lualine
- Decrease hide in width limit for lualine
- Add support for fsharp (#2021)
- Add some messages in uninstall.sh (#1945)
- Null-ls code_actions interface (#2008)
- Full compatibility with neovim v0.6 (#2037)
- Multiple enhancements to lvim-reload (#2054)
- Bump plugin versions (#2064)
- Update lsp-installer and lspconfig hashes to enable solidity_ls language server (#2072)

### <!-- 2 --> Bugfix

- _(autopairs)_ Add missing configuration entries (#2030)
- _(bootstrap)_ Remove hard-coded spellfile option (#2061)
- _(cmp)_ Revert broken sequential loading (#2002)
- _(installer)_ Better handling of existing files (#2066)
- _(lsp)_ Avoid installing an overridden server (#1981)
- _(lsp)_ Prevent repeated setup call (#2048)
- _(lsp)_ Correct client_id parsing in lvim-info (#2071)
- _(lsp)_ Allow overriding servers with custom providers (#2070)
- _(lualine)_ Change `fg` of section `a` in onedarker (#1909)
- _(null-ls)_ Allow the same linter and formatter (#1968)
- _(nvimtree)_ Update settings (#2001)
- _(nvimtree)_ Restore default mappings + make them customizable (#2007)
- _(nvimtree)_ Handle paths containing spaces (#2027)
- _(plugins)_ Typo of pin commit of `treesitter` (#2046)
- _(terminal)_ Allow disabling the open binding for toggleterm
- _(windows)_ Autocmd requires forward slashes (#1967)
- _(windows)_ Remove redundant `resolve` call (#1974)
- Bump nvim-tree version
- Formatting
- Remove duplicate lint messages
- Allow LunarVim changelog to work outside the lvim directory (#1952)
- Use an indepdent shadafile from neovim (#1910)
- Packersync issue when you have large number of plugins (#1922)
- No idea why this breaks barbar
- Lsp root can get very annoying when working with multiple languages. User is still able to turn it on.
- Update jdtls script
- Correct order for cmp's setup (#1999)
- Dont close if next char is a close pair and no pairs in same line (#2017)
- More accessible changelog (#2019)
- Better default, ignore `.git` in `live_grep` (#2020)
- No restart required when changing colorscheme (#2026)
- No longer treat lazygit missing as an error (#2051)

### <!-- 3 --> Refactor

- Deprecate lvim.lang.FOO (#1913) (#1914)
- More configurable format-on-save (#1937)
- Load the default keymaps once (#1965)

<!-- generated by git-cliff -->
