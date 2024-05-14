# Changelog

All notable changes to this project will be documented in this file.

## [1.4.0]

### <!-- 1 --> Features

- _(installer)_ added bun as a js package manager ([#4362](https://github.com/lunarvim/lunarvim/pull/4362))
- _(lspconfig)_ add rounded borders to :LspInfo window ([#4208](https://github.com/lunarvim/lunarvim/pull/4208))
- _(nvimtree)_ centralize selection ([#4160](https://github.com/lunarvim/lunarvim/pull/4160))
- _(plugins)_ migrate from `null-ls` to `none-ls` ([#4392](https://github.com/lunarvim/lunarvim/pull/4392))
- simplify example config, add links for user instead ([#4128](https://github.com/lunarvim/lunarvim/pull/4128))
- don't move config on install ([#4129](https://github.com/lunarvim/lunarvim/pull/4129))
- rounded border for hover and signatureHelp ([#4131](https://github.com/lunarvim/lunarvim/pull/4131))
- lock new installations to nvim 0.9+ ([#3858](https://github.com/lunarvim/lunarvim/pull/3858))
- use code chevrons ([#4184](https://github.com/lunarvim/lunarvim/pull/4184))
- ignore missing keys for whichkey ([#4185](https://github.com/lunarvim/lunarvim/pull/4185))
- [**breaking**] use prompts similar to `:confirm` in `buf_kill` ([#4186](https://github.com/lunarvim/lunarvim/pull/4186))
- add starter.lvim link to config.example.lua ([#4200](https://github.com/lunarvim/lunarvim/pull/4200))
- add example to the packer deprecation message ([#4201](https://github.com/lunarvim/lunarvim/pull/4201))

### <!-- 2 --> Bugfix

- _(alpha)_ account for different icon byte sizes ([#4130](https://github.com/lunarvim/lunarvim/pull/4130))
- _(dap)_ ui opens when debugging ([#4116](https://github.com/lunarvim/lunarvim/pull/4116))
- _(default-options)_ remove invalid guifont option ([#4447](https://github.com/lunarvim/lunarvim/pull/4447))
- _(deprecation)_ only deprecate `tag == "*"` in lvim.plugins ([#4297](https://github.com/lunarvim/lunarvim/pull/4297))
- _(icons)_ add some whitespace to the boolean icon ([#4163](https://github.com/lunarvim/lunarvim/pull/4163))
- _(install)_ add newline after setup message ([#4533](https://github.com/lunarvim/lunarvim/pull/4533))
- _(installer)_ dependency installation for Windows ([#4486](https://github.com/lunarvim/lunarvim/pull/4486))
- _(lsp)_ add luv library by default to lua_ls ([#4067](https://github.com/lunarvim/lunarvim/pull/4067))
- _(lsp)_ diagnostic codes already show by default ([#4070](https://github.com/lunarvim/lunarvim/pull/4070))
- [**breaking**] _(lsp)_ switch to csharp_ls to avoid startup errors ([#4079](https://github.com/lunarvim/lunarvim/pull/4079))
- _(lsp)_ lazy load mason on FileOpened ([#4100](https://github.com/lunarvim/lunarvim/pull/4100))
- _(lsp)_ skip auto config server even if it's ensure installed ([#4243](https://github.com/lunarvim/lunarvim/pull/4243))
- _(lsp)_ restore float border ([#4274](https://github.com/lunarvim/lunarvim/pull/4274))
- _(lsp)_ adapt recent changes in `nvim-lspconfig` ([#4348](https://github.com/lunarvim/lunarvim/pull/4348))
- _(lualine)_ use get_active_clients instead of deprecated function ([#4136](https://github.com/lunarvim/lunarvim/pull/4136))
- _(nvim-tree)_ use local buffer keymaps ([#4090](https://github.com/lunarvim/lunarvim/pull/4090))
- _(terminal)_ show lazygit bottom line ([#4548](https://github.com/lunarvim/lunarvim/pull/4548))
- _(tests)_ set up lazy.nvim in the lsp test ([#4088](https://github.com/lunarvim/lunarvim/pull/4088))
- _(treesitter)_ add a few parsers to `ensure_installed` ([#4121](https://github.com/lunarvim/lunarvim/pull/4121))
- _(typo)_ `form` to `from` ([#4295](https://github.com/lunarvim/lunarvim/pull/4295))
- _(user_command)_ update url in `LvimDocs` command ([#4081](https://github.com/lunarvim/lunarvim/pull/4081))
- _(win)_ remove '-NoLogo' from vim.opt.shell ([#4232](https://github.com/lunarvim/lunarvim/pull/4232))
- add missing LF to install script ([#4075](https://github.com/lunarvim/lunarvim/pull/4075))
- replace obsolete icons ([#4111](https://github.com/lunarvim/lunarvim/pull/4111))
- correct runtimepath order ([#4124](https://github.com/lunarvim/lunarvim/pull/4124))
- support text if marksman lang server ([#4144](https://github.com/lunarvim/lunarvim/pull/4144))
- circle icons was being cut off for some fonts
- handle context-commentstring setup ([#4451](https://github.com/lunarvim/lunarvim/pull/4451))

### <!-- 3 --> Refactor

- [**breaking**] _(lsp)_ deprecate `lvim.lsp.diagnostics` ([#3916](https://github.com/lunarvim/lunarvim/pull/3916))
- _(lualine)_ use `string.format` to return unique names ([#4193](https://github.com/lunarvim/lunarvim/pull/4193))

### <!-- 4 --> Documentation

- add code_actions to example config ([#4029](https://github.com/lunarvim/lunarvim/pull/4029))
- update broken links in example configs ([#4097](https://github.com/lunarvim/lunarvim/pull/4097))
- use `master` instead of `rolling` in contributing.md ([#4115](https://github.com/lunarvim/lunarvim/pull/4115))
- use `master` instead of `rolling` in contributing.md ([#4115](https://github.com/lunarvim/lunarvim/pull/4115))

### <!-- 6 --> Performance

- _(installer)_ use a shallow clone of lunarvim ([#4197](https://github.com/lunarvim/lunarvim/pull/4197))

## [1.3.0]

### <!-- 1 --> Features

- _(alpha)_ allow configuring highlight groups ([#3532](https://github.com/lunarvim/lunarvim/pull/3532))
- _(alpha)_ add quit button to dashboard ([#3767](https://github.com/lunarvim/lunarvim/pull/3767))
- _(autocmds)_ add `NvimTreeNormalNC` to transparent mode ([#3850](https://github.com/lunarvim/lunarvim/pull/3850))
- _(cmp)_ add on_config_done callback ([#3589](https://github.com/lunarvim/lunarvim/pull/3589))
- _(dap)_ update dap ui to resize when toggled ([#3606](https://github.com/lunarvim/lunarvim/pull/3606))
- _(dap-ui)_ update setup table ([#3724](https://github.com/lunarvim/lunarvim/pull/3724))
- _(installer)_ list dependencies that will be installed ([#3523](https://github.com/lunarvim/lunarvim/pull/3523))
- _(installer)_ allow customizing NVIM_APPNAME ([#3896](https://github.com/lunarvim/lunarvim/pull/3896))
- _(keybindings)_ operator pending mode ([#3626](https://github.com/lunarvim/lunarvim/pull/3626))
- _(keybindings)_ add code action to visual mode ([#4022](https://github.com/lunarvim/lunarvim/pull/4022))
- _(lang)_ yaml use schemastore ([#3953](https://github.com/lunarvim/lunarvim/pull/3953))
- _(lazy)_ lazy.nvim settings can be customized ([#4010](https://github.com/lunarvim/lunarvim/pull/4010))
- _(lsp)_ focusable line diagnostics ([#3622](https://github.com/lunarvim/lunarvim/pull/3622))
- _(mason)_ add support for mason-registry ([#3994](https://github.com/lunarvim/lunarvim/pull/3994))
- _(mason)_ add on_config_done option to lvim.builtin.mason ([#3991](https://github.com/lunarvim/lunarvim/pull/3991))
- _(reload)_ add all conf files to aupat ([#3644](https://github.com/lunarvim/lunarvim/pull/3644))
- _(tailwind)_ add .ts options to tailwind.config root_pattern ([#4016](https://github.com/lunarvim/lunarvim/pull/4016))
- _(telescope)_ add `lvim.builtin.telescope.theme` ([#3548](https://github.com/lunarvim/lunarvim/pull/3548))
- _(ts)_ enable indent for c and cpp ([#3783](https://github.com/lunarvim/lunarvim/pull/3783))
- _(which-key)_ keybind for `:Telescope resume` ([#3826](https://github.com/lunarvim/lunarvim/pull/3826))
- _(wich-key)_ binding to save without formatting ([#3165](https://github.com/lunarvim/lunarvim/pull/3165))
- add command & keybind to view docs ([#3426](https://github.com/lunarvim/lunarvim/pull/3426))
- configure dap logging ([#3454](https://github.com/lunarvim/lunarvim/pull/3454))
- support 'hrsh7th/cmp-cmdline' by default ([#3545](https://github.com/lunarvim/lunarvim/pull/3545))
- don't prompt smart quit when buffer open in another window ([#3636](https://github.com/lunarvim/lunarvim/pull/3636))
- use codicons that are available for nerdfonts now ([#3646](https://github.com/lunarvim/lunarvim/pull/3646))
- update setup tables ([#3693](https://github.com/lunarvim/lunarvim/pull/3693))
- enable auto preview colorscheme by default ([#3701](https://github.com/lunarvim/lunarvim/pull/3701))
- cmdline config option enables cmp-cmdline plugin ([#3719](https://github.com/lunarvim/lunarvim/pull/3719))
- add crystal filetype ([#3762](https://github.com/lunarvim/lunarvim/pull/3762))
- include git status in LvimVersion ([#3774](https://github.com/lunarvim/lunarvim/pull/3774))
- regenerate lsp templates after LvimUpdate ([#3864](https://github.com/lunarvim/lunarvim/pull/3864))

### <!-- 2 --> Bugfix

- _(alpha)_ make dashboard responsive ([#3505](https://github.com/lunarvim/lunarvim/pull/3505))
- _(alpha)_ check height of the aplha window ([#3585](https://github.com/lunarvim/lunarvim/pull/3585))
- _(alpha)_ rollback to older commit ([#3832](https://github.com/lunarvim/lunarvim/pull/3832))
- _(autocmds)_ add separate autoreload config group  ([#3436](https://github.com/lunarvim/lunarvim/pull/3436))
- _(autocmds)_ remove spell autocmd ([#3487](https://github.com/lunarvim/lunarvim/pull/3487))
- _(autopairs)_ attach confirm_done only once ([#3430](https://github.com/lunarvim/lunarvim/pull/3430))
- _(bootstrap)_ delay lsp setup until LazyDone ([#4041](https://github.com/lunarvim/lunarvim/pull/4041))
- _(breadcrumbs)_ `E36 Not enough space` when using dap-ui `Eval` ([#3533](https://github.com/lunarvim/lunarvim/pull/3533))
- _(breadcrumbs)_ use hlgroup from web devicons in breadcrumbs ([#3342](https://github.com/lunarvim/lunarvim/pull/3342))
- _(breadcrumbs)_ refresh on TabEnter ([#3727](https://github.com/lunarvim/lunarvim/pull/3727))
- _(breadcrumbs)_ disable for neotest ([#3921](https://github.com/lunarvim/lunarvim/pull/3921))
- _(bufferline)_ fallback to empty table if `buf_nums` is nil ([#3473](https://github.com/lunarvim/lunarvim/pull/3473))
- _(bufkill)_ wrap around correctly ([#3461](https://github.com/lunarvim/lunarvim/pull/3461))
- _(bufkill)_ wait for user's input ([#3535](https://github.com/lunarvim/lunarvim/pull/3535))
- _(cmp)_ handle deprecated tree-sitter api ([#3853](https://github.com/lunarvim/lunarvim/pull/3853))
- _(config)_ use a minimal bootstrap for mason ([#3427](https://github.com/lunarvim/lunarvim/pull/3427))
- _(config)_ fix typo in example configs ([#3611](https://github.com/lunarvim/lunarvim/pull/3611))
- _(config)_ copy the correct example config ([#3722](https://github.com/lunarvim/lunarvim/pull/3722))
- _(config-loader)_ defer invalid configuration warning ([#3869](https://github.com/lunarvim/lunarvim/pull/3869))
- _(dap)_ invalid border value ([#3951](https://github.com/lunarvim/lunarvim/pull/3951))
- _(dashboard)_ remove feedkeys ([#3558](https://github.com/lunarvim/lunarvim/pull/3558))
- _(icons)_ make devicons optional ([#3616](https://github.com/lunarvim/lunarvim/pull/3616))
- _(indentlines)_ set indent_char to LineLeft ([#3741](https://github.com/lunarvim/lunarvim/pull/3741))
- _(indentlines)_ typo ([#3743](https://github.com/lunarvim/lunarvim/pull/3743))
- _(installer)_ fix syntax error with powershell installer ([#2875](https://github.com/lunarvim/lunarvim/pull/2875))
- _(installer)_ only install treesitter-cli if it's missing ([#3740](https://github.com/lunarvim/lunarvim/pull/3740))
- _(installer)_ validation step was failing on windows ([#4008](https://github.com/lunarvim/lunarvim/pull/4008))
- _(lir)_ nil check, simpler logic ([#3725](https://github.com/lunarvim/lunarvim/pull/3725))
- _(logger)_ fix errors with older structlog versions ([#3755](https://github.com/lunarvim/lunarvim/pull/3755))
- _(lsp)_ disable annoying popup for sumneko-lua ([#3445](https://github.com/lunarvim/lunarvim/pull/3445))
- _(lsp)_ some servers have dynamic commands ([#3471](https://github.com/lunarvim/lunarvim/pull/3471))
- _(lsp)_ sumneko-lua library scanning ([#3484](https://github.com/lunarvim/lunarvim/pull/3484))
- _(lsp)_ add neocmake to skipped_servers ([#3597](https://github.com/lunarvim/lunarvim/pull/3597))
- _(lsp)_ don't remove mason-lspconfig's hook ([#3739](https://github.com/lunarvim/lunarvim/pull/3739))
- _(lsp)_ info diagnostic icon not showing ([#3756](https://github.com/lunarvim/lunarvim/pull/3756))
- _(lsp)_ lazy loading ([#3824](https://github.com/lunarvim/lunarvim/pull/3824))
- _(lsp)_ template generation for filetypes with dots ([#3833](https://github.com/lunarvim/lunarvim/pull/3833))
- _(lsp)_ incorrect `g` goto capitalization ([#3950](https://github.com/lunarvim/lunarvim/pull/3950))
- _(lsp)_ add luv library by default to lua_ls ([#4067](https://github.com/lunarvim/lunarvim/pull/4067))
- _(nvim-tree)_ remove deprecated option (nvim-tree/nvim-tree.lua#2122) ([#4033](https://github.com/lunarvim/lunarvim/pull/4033))
- _(nvimtree)_ avoid hard-coded mapping ([#3492](https://github.com/lunarvim/lunarvim/pull/3492))
- _(nvimtree)_ don't overwrite update_focused_file.ignore_list ([#3986](https://github.com/lunarvim/lunarvim/pull/3986))
- _(packer)_ increase clone timeout in headless ([#3470](https://github.com/lunarvim/lunarvim/pull/3470))
- _(plugin-loader)_ don't clean lazy.nvim in sync_core_plugins ([#3731](https://github.com/lunarvim/lunarvim/pull/3731))
- _(plugin-loader)_ don't clean plugins on LvimUpdate ([#3747](https://github.com/lunarvim/lunarvim/pull/3747))
- _(plugin-loader)_ support older git versions ([#3769](https://github.com/lunarvim/lunarvim/pull/3769))
- _(snapshots)_ correct tokyonight commit sha ([#3620](https://github.com/lunarvim/lunarvim/pull/3620))
- _(telescope)_ backwards compability ([#3596](https://github.com/lunarvim/lunarvim/pull/3596))
- _(terminal)_ use user's shell in execs ([#3531](https://github.com/lunarvim/lunarvim/pull/3531))
- _(terminal)_ don't set the shell by default ([#3867](https://github.com/lunarvim/lunarvim/pull/3867))
- _(tree-sitter)_ force update bundled parsers ([#3475](https://github.com/lunarvim/lunarvim/pull/3475))
- _(treesitter)_ prepend to rtp ([#3708](https://github.com/lunarvim/lunarvim/pull/3708))
- _(ts)_ disable indent for c and cpp ([#3687](https://github.com/lunarvim/lunarvim/pull/3687))
- _(uninstaller)_ add separate flag to remove user config ([#3508](https://github.com/lunarvim/lunarvim/pull/3508))
- _(uninstaller)_ correct a sentence in help ([#3511](https://github.com/lunarvim/lunarvim/pull/3511))
- _(which-key)_ typo ([#3963](https://github.com/lunarvim/lunarvim/pull/3963))
- add dap-ui config to lvim.builtin.dap ([#3386](https://github.com/lunarvim/lunarvim/pull/3386))
- cmp will behave closer to how people expect
- discard invalid choice when closing buffers ([#3488](https://github.com/lunarvim/lunarvim/pull/3488))
- startify theme button bugfix ([#3557](https://github.com/lunarvim/lunarvim/pull/3557))
- only call theme's setup if it's selected ([#3586](https://github.com/lunarvim/lunarvim/pull/3586))
- bash installer errors ([#3686](https://github.com/lunarvim/lunarvim/pull/3686))
- remove deprecated nvim-tree options ([#3810](https://github.com/lunarvim/lunarvim/pull/3810))
- win installer syntax error ([#3635](https://github.com/lunarvim/lunarvim/pull/3635))
- lazy cache ([#3892](https://github.com/lunarvim/lunarvim/pull/3892))
- copilot indent reset ([#3343](https://github.com/lunarvim/lunarvim/pull/3343)) ([#3960](https://github.com/lunarvim/lunarvim/pull/3960))
- typo ([#4023](https://github.com/lunarvim/lunarvim/pull/4023))
- use `require` instead of `reload` in pcalls  ([#4038](https://github.com/lunarvim/lunarvim/pull/4038))
- make FileOpened autocmd work with quickfix ([#4040](https://github.com/lunarvim/lunarvim/pull/4040))

### <!-- 3 --> Refactor

- _(alpha)_ remove laststatus and tabline autocmds ([#3809](https://github.com/lunarvim/lunarvim/pull/3809))
- _(autocmds)_ clean up filetype detection rules ([#3625](https://github.com/lunarvim/lunarvim/pull/3625))
- _(logger)_ adapt to new changes upstream ([#3695](https://github.com/lunarvim/lunarvim/pull/3695))
- [**breaking**] _(quit)_ use native quit confirm ([#3721](https://github.com/lunarvim/lunarvim/pull/3721))
- [**breaking**] _(treesitter)_ use auto-install by default ([#3677](https://github.com/lunarvim/lunarvim/pull/3677))
- move dap keybindings to which key  ([#3459](https://github.com/lunarvim/lunarvim/pull/3459))
- simplify example config ([#3519](https://github.com/lunarvim/lunarvim/pull/3519))
- use lir fork in the org ([#3694](https://github.com/lunarvim/lunarvim/pull/3694))
- move to upstream lir ([#3711](https://github.com/lunarvim/lunarvim/pull/3711))
- [**breaking**] remove `%` and `$` autopairs rules ([#3759](https://github.com/lunarvim/lunarvim/pull/3759))

### <!-- 4 --> Documentation

- _(contributing)_ make it clear how to title PRs ([#3463](https://github.com/lunarvim/lunarvim/pull/3463))
- _(ts)_ add hint about `ensure_installed` ([#3827](https://github.com/lunarvim/lunarvim/pull/3827))
- github pull request template update ([#3512](https://github.com/lunarvim/lunarvim/pull/3512))

### <!-- 6 --> Performance

- _(toggleterm)_ on-demand lazy load ([#3811](https://github.com/lunarvim/lunarvim/pull/3811))
- handle big files better ([#3449](https://github.com/lunarvim/lunarvim/pull/3449))
- lazy load most plugins ([#3750](https://github.com/lunarvim/lunarvim/pull/3750))

## [1.2.0]

### <!-- 1 --> Features

- _(autocmds)_ make sure all autocmds are modifiable ([#3087](https://github.com/lunarvim/lunarvim/pull/3087))
- _(cmp)_ add configs for cmp.setup.cmdline ([#3180](https://github.com/lunarvim/lunarvim/pull/3180))
- _(config)_ allow disabling reload-on-save ([#3261](https://github.com/lunarvim/lunarvim/pull/3261))
- _(dap)_ red bugs and other highlight improvements
- _(dap)_ buffernames for elements, icons, hide dap-repl by default ([#3156](https://github.com/lunarvim/lunarvim/pull/3156))
- _(document highlight)_ use illuminate rather than autocommand to avoid flashing ([#3029](https://github.com/lunarvim/lunarvim/pull/3029))
- _(indentblankline)_ show first indent level
- _(installer)_ handle INSTALL_PREFIX not on PATH ([#2912](https://github.com/lunarvim/lunarvim/pull/2912))
- _(installer)_ desktop entry ([#3187](https://github.com/lunarvim/lunarvim/pull/3187))
- _(logger)_ hot-reload logger level ([#3159](https://github.com/lunarvim/lunarvim/pull/3159))
- _(lualine)_ update statusline
- _(lualine)_ improvements
- _(lvim/lsp)_ enable tailwindcss by default ([#2870](https://github.com/lunarvim/lunarvim/pull/2870))
- _(telecope)_ set show_untracked by default ([#2984](https://github.com/lunarvim/lunarvim/pull/2984))
- _(terminal)_ better mappings ([#3104](https://github.com/lunarvim/lunarvim/pull/3104))
- _(uninstaller)_ desktop entry
- _(whichkey)_ add default keybindings to cycle to next buffer ([#2873](https://github.com/lunarvim/lunarvim/pull/2873))
- add lir.nvim ([#3031](https://github.com/lunarvim/lunarvim/pull/3031))
- add lir.nvim again ([#3038](https://github.com/lunarvim/lunarvim/pull/3038))
- new colorscheme tokyonight ([#3041](https://github.com/lunarvim/lunarvim/pull/3041))
- a less noisy tree ([#3042](https://github.com/lunarvim/lunarvim/pull/3042))
- breadcrumbs ([#3043](https://github.com/lunarvim/lunarvim/pull/3043))
- use a shorter dashboard banner when needed ([#3047](https://github.com/lunarvim/lunarvim/pull/3047))
- illuminate works again
- breadcrumbs work again
- new dashboard logo
- set options to remove some noise
- laststatus=3 global statusline
- better telescopic experience ([#3052](https://github.com/lunarvim/lunarvim/pull/3052))
- pickers ([#3053](https://github.com/lunarvim/lunarvim/pull/3053))
- add indentlines ([#3056](https://github.com/lunarvim/lunarvim/pull/3056))
- only show reloaded config on debug log level to decrease noise
- add border for mason ([#3080](https://github.com/lunarvim/lunarvim/pull/3080))
- colorscheme tweaks
- reload and lir color update ([#3123](https://github.com/lunarvim/lunarvim/pull/3123))
- now, when you're hovering over a require('a.b.c'), you can type gf, and go to the 'c.lua' file ([#3122](https://github.com/lunarvim/lunarvim/pull/3122))
- move icons to a single icons file ([#3115](https://github.com/lunarvim/lunarvim/pull/3115))
- add some more reloads ([#3126](https://github.com/lunarvim/lunarvim/pull/3126))
- add space after breadcrumb icons ([#3128](https://github.com/lunarvim/lunarvim/pull/3128))
- add missing nvimtree setting ([#3138](https://github.com/lunarvim/lunarvim/pull/3138))
- added dap ui and relative config ([#3131](https://github.com/lunarvim/lunarvim/pull/3131))
- terminal, dap, and notify active by default
- all features active by default ([#3157](https://github.com/lunarvim/lunarvim/pull/3157))
- lock new installations to nvim 0.8+ ([#3111](https://github.com/lunarvim/lunarvim/pull/3111))
- enable global installation ([#3161](https://github.com/lunarvim/lunarvim/pull/3161))
- add new copilot and other sources ([#3171](https://github.com/lunarvim/lunarvim/pull/3171))
- use icon for copilot in statusline ([#3173](https://github.com/lunarvim/lunarvim/pull/3173))
- buffer cmp for search, and path for command mode ([#3147](https://github.com/lunarvim/lunarvim/pull/3147))
- reduce noise from LSP text comes from buffer source anyway
- warn user when setting un-installed colorscheme ([#2982](https://github.com/lunarvim/lunarvim/pull/2982))
- latest impatient updates from upstream ([#3236](https://github.com/lunarvim/lunarvim/pull/3236))
- dynamic or fixed toggle terminal size ([#3110](https://github.com/lunarvim/lunarvim/pull/3110))
- toggle cmp active ([#3398](https://github.com/lunarvim/lunarvim/pull/3398))
- breadcrumbs autocommand only runs when active ([#3399](https://github.com/lunarvim/lunarvim/pull/3399))
- Add chevron to breadcrumbs (with matching highlight group) ([#3380](https://github.com/lunarvim/lunarvim/pull/3380))
- use our own colorscheme, decouple from tokyonight ([#3378](https://github.com/lunarvim/lunarvim/pull/3378))
- only use orange branch for lunar colorscheme

### <!-- 2 --> Bugfix

- _(alpha)_ can't set button hl without doing this
- _(alpha)_ check alpha module ([#3233](https://github.com/lunarvim/lunarvim/pull/3233))
- _(alpha)_ make startify sections always appear ([#3371](https://github.com/lunarvim/lunarvim/pull/3371))
- _(autocmds)_ remove _format_options group ([#3278](https://github.com/lunarvim/lunarvim/pull/3278))
- _(breadcrumbs)_ make sure winbar_filetype_exclude is customizable ([#3221](https://github.com/lunarvim/lunarvim/pull/3221))
- _(bufferline)_ use buf kill on close ([#3422](https://github.com/lunarvim/lunarvim/pull/3422))
- _(ci)_ resolve stylua ci rare error ([#3065](https://github.com/lunarvim/lunarvim/pull/3065))
- _(cmp)_ do not mutate the original confirm_opts on CR ([#2979](https://github.com/lunarvim/lunarvim/pull/2979))
- _(cmp)_ fix cmp select on CR ([#2980](https://github.com/lunarvim/lunarvim/pull/2980))
- _(config)_ more comprehensive cache reset ([#3416](https://github.com/lunarvim/lunarvim/pull/3416))
- _(core/autocmds)_ do not check for existence on clear_augroup ([#2963](https://github.com/lunarvim/lunarvim/pull/2963))
- _(dashboard)_ add missing space ([#3063](https://github.com/lunarvim/lunarvim/pull/3063))
- _(defaults)_ don't use smartindent ([#3363](https://github.com/lunarvim/lunarvim/pull/3363))
- _(example config)_ fix config for treesitter ([#3016](https://github.com/lunarvim/lunarvim/pull/3016))
- _(finders)_ use lunarvim basedir ([#3332](https://github.com/lunarvim/lunarvim/pull/3332))
- _(icons)_ do not reload `nvim-web-devicons` module ([#3344](https://github.com/lunarvim/lunarvim/pull/3344))
- _(indentblankline)_ make sure to use the new syntax for all options ([#3058](https://github.com/lunarvim/lunarvim/pull/3058))
- _(installer)_ create profile.ps1 if nonexistent ([#2810](https://github.com/lunarvim/lunarvim/pull/2810))
- _(installer)_ small fix in help message of install.sh ([#3032](https://github.com/lunarvim/lunarvim/pull/3032))
- _(installer)_ don't overwrite previous config ([#3154](https://github.com/lunarvim/lunarvim/pull/3154))
- _(installer)_ don't set log level
- _(installer)_ Use master in windows installer ([#3421](https://github.com/lunarvim/lunarvim/pull/3421))
- _(installer)_ use quotes in set-alias ([#3408](https://github.com/lunarvim/lunarvim/pull/3408))
- _(log)_ correct add_entry code documentation ([#3081](https://github.com/lunarvim/lunarvim/pull/3081))
- _(logger)_ set console logging to sync ([#3379](https://github.com/lunarvim/lunarvim/pull/3379))
- _(lsp)_ return the actual resolved mason-config ([#2889](https://github.com/lunarvim/lunarvim/pull/2889))
- _(lsp)_ pass name arg to should_auto_install ([#2958](https://github.com/lunarvim/lunarvim/pull/2958))
- _(lsp)_ enforce lvim completion for lua-server ([#3035](https://github.com/lunarvim/lunarvim/pull/3035))
- _(lsp)_ don't start servers multiple times ([#3347](https://github.com/lunarvim/lunarvim/pull/3347))
- _(lsp)_ do a nil check before string matching autocmd desc ([#3354](https://github.com/lunarvim/lunarvim/pull/3354))
- _(lsp)_ only launch installed servers ([#3366](https://github.com/lunarvim/lunarvim/pull/3366))
- _(lsp/utils)_ do not register duplicate autocommands ([#3004](https://github.com/lunarvim/lunarvim/pull/3004))
- _(lua-dev)_ make sure we are loading the correct types ([#3208](https://github.com/lunarvim/lunarvim/pull/3208))
- _(luadev)_ this plugin has been renamed ([#3235](https://github.com/lunarvim/lunarvim/pull/3235))
- _(lualine)_ set icon color according to the status of treesitter ([#2754](https://github.com/lunarvim/lunarvim/pull/2754))
- _(lualine)_ little more padding
- _(lualine)_ guard setup on install ([#3185](https://github.com/lunarvim/lunarvim/pull/3185))
- _(lualine)_ globalstatus=true by default
- _(nvim-cmp-lsp)_ update_capabilities has been deprecated ([#3245](https://github.com/lunarvim/lunarvim/pull/3245))
- _(nvimtree)_ remove view height
- _(plugins)_ bring back original folke repos ([#2992](https://github.com/lunarvim/lunarvim/pull/2992))
- _(plugins)_ handle deprecated options ([#3014](https://github.com/lunarvim/lunarvim/pull/3014))
- _(plugins)_ set max jobs to 50 on mac
- _(statusline)_ display null-ls linters properly ([#2921](https://github.com/lunarvim/lunarvim/pull/2921))
- _(terminal)_ slightly bigger vertical terminal
- _(theme)_ do not fallback to tokyonight if no user's theme found ([#3327](https://github.com/lunarvim/lunarvim/pull/3327))
- _(ts_context_commentstring)_ block comment match new api ([#2948](https://github.com/lunarvim/lunarvim/pull/2948))
- _(typo)_ fix language server name typo in config example ([#3176](https://github.com/lunarvim/lunarvim/pull/3176))
- _(typo)_ fix language server name typo in config example #3176 ([#3183](https://github.com/lunarvim/lunarvim/pull/3183))
- handle deprecated telescope.builtin.internal ([#2885](https://github.com/lunarvim/lunarvim/pull/2885))
- update key bindings for comment.nvim to use new api ([#2926](https://github.com/lunarvim/lunarvim/pull/2926))
- remove warning message
- make sure latest plugins are customizable ([#3044](https://github.com/lunarvim/lunarvim/pull/3044))
- quick and dirty fix for global statusline
- add branch export for rolling installation ([#3054](https://github.com/lunarvim/lunarvim/pull/3054))
- lag in space when in terminal insert
- fixing laststatus harder
- make sure to use global in lualine
- more consistent dashboard description ([#3055](https://github.com/lunarvim/lunarvim/pull/3055))
- always load base theme
- plain tokyonight
- lualine filetype padding
- lualine git signs padding
- improve lualine inactive
- lualine slightly better
- use columns instead of winwidth
- lualine laststatus nuclear option
- pcall for dashboard
- small fixes on telescope pickers & breadcrumbs ([#3060](https://github.com/lunarvim/lunarvim/pull/3060))
- supertab should tab if menu is not available ([#3079](https://github.com/lunarvim/lunarvim/pull/3079))
- update minimal_lsp.lua ([#3090](https://github.com/lunarvim/lunarvim/pull/3090))
- set `lua-dev.nvim` to a valid commit version ([#3096](https://github.com/lunarvim/lunarvim/pull/3096))
- add lunarvim/lvim/after to rtp
- correct typos ([#3117](https://github.com/lunarvim/lunarvim/pull/3117))
- idk why it has an issue here but we can't use reload in the plugins file for now
- don't ignore plugin this way ([#3125](https://github.com/lunarvim/lunarvim/pull/3125))
- esc exit autocommand
- always use border for lsp hover ([#3160](https://github.com/lunarvim/lunarvim/pull/3160))
- nvim_dap has an issue with setting winbar for dapui_console filetype
- formatting
- telescope delete_buffer binds correct scope
- move telescope.actions pcall to the top
- use function for pickers
- Remove J and K key mappings for move ([#3206](https://github.com/lunarvim/lunarvim/pull/3206))
- typo in git.lua
- name treesitter source in cmp ([#3223](https://github.com/lunarvim/lunarvim/pull/3223))
- don't install desktop file w/o xdg-desktop-menu ([#3229](https://github.com/lunarvim/lunarvim/pull/3229))
- disable gitsigns hunk navigation message ([#3244](https://github.com/lunarvim/lunarvim/pull/3244))
- copilot background should matcha statusline
- disable unsupported asian characters spellchecking ([#3259](https://github.com/lunarvim/lunarvim/pull/3259))
- nil table in breadcrumbs in autocommand ([#3267](https://github.com/lunarvim/lunarvim/pull/3267))
- Remove notify which key mapping ([#3335](https://github.com/lunarvim/lunarvim/pull/3335))
- call proper log function in notify override ([#3337](https://github.com/lunarvim/lunarvim/pull/3337))
- statusline and breadcrumbs hls reload with config reload ([#3376](https://github.com/lunarvim/lunarvim/pull/3376))
- revert ColorScheme autocmd execution ([#3397](https://github.com/lunarvim/lunarvim/pull/3397))
- don't complete in prompt ft
- rollback plugin loader changes ([#3402](https://github.com/lunarvim/lunarvim/pull/3402))

### <!-- 3 --> Refactor

- [**breaking**] _(cmp)_ adapt new recommendations ([#2913](https://github.com/lunarvim/lunarvim/pull/2913))
- _(config)_ better deprecation handling ([#3419](https://github.com/lunarvim/lunarvim/pull/3419))
- _(hooks)_ use colorscheme event after reload ([#3375](https://github.com/lunarvim/lunarvim/pull/3375))
- _(installer)_ skip unstable headless update ([#3338](https://github.com/lunarvim/lunarvim/pull/3338))
- [**breaking**] _(keymaps)_ don't hijack H/L by default ([#2874](https://github.com/lunarvim/lunarvim/pull/2874))
- [**breaking**] _(plugins)_ remove nvim-notify from core ([#3300](https://github.com/lunarvim/lunarvim/pull/3300))
- [**breaking**] _(theme)_ decouple tokyonight options ([#3384](https://github.com/lunarvim/lunarvim/pull/3384))
- [**breaking**] migrate to mason.nvim ([#2880](https://github.com/lunarvim/lunarvim/pull/2880))
- small improvements ([#3021](https://github.com/lunarvim/lunarvim/pull/3021))
- smaller timeout for packer ([#2910](https://github.com/lunarvim/lunarvim/pull/2910))
- more deliberate reload ([#3133](https://github.com/lunarvim/lunarvim/pull/3133))
- clean up test env paths ([#3318](https://github.com/lunarvim/lunarvim/pull/3318))

### <!-- 4 --> Documentation

- _(lsp)_ fix the way of removing items from skipped_servers ([#2887](https://github.com/lunarvim/lunarvim/pull/2887))
- _(readme)_ recommend rolling for 0.8, remove old breaking changes ([#3028](https://github.com/lunarvim/lunarvim/pull/3028))
- _(windows)_ update example config for nvim-tree ([#2766](https://github.com/lunarvim/lunarvim/pull/2766))
- _(windows)_ update example config ([#2919](https://github.com/lunarvim/lunarvim/pull/2919))
- fix some typos and enhance readability ([#2917](https://github.com/lunarvim/lunarvim/pull/2917))
- fix automatic_servers_installation example ([#2918](https://github.com/lunarvim/lunarvim/pull/2918))
- update images
- Replace Tree-sitter `maintained` with `all` in README ([#3088](https://github.com/lunarvim/lunarvim/pull/3088))
- Update contributing readme with new url for install docs. ([#3254](https://github.com/lunarvim/lunarvim/pull/3254))
- Update Readme ([#3282](https://github.com/lunarvim/lunarvim/pull/3282))
- remove and reorganize images ([#3302](https://github.com/lunarvim/lunarvim/pull/3302))
- update readme ([#3303](https://github.com/lunarvim/lunarvim/pull/3303))
- update colors for links in readme

### <!-- 5 --> Revert

- remove incomplete lir integration ([#3030](https://github.com/lunarvim/lunarvim/pull/3030))
- lir.nvim is still broken ([#3036](https://github.com/lunarvim/lunarvim/pull/3036))
- fix Packer instead of hard-coding config ([#3049](https://github.com/lunarvim/lunarvim/pull/3049))

### <!-- 6 --> Performance

- _(plugins)_ move assert `vim.env.LVIM_DEV_MODE` logic ([#3238](https://github.com/lunarvim/lunarvim/pull/3238))
- _(treesitter)_ disable in big files ([#3268](https://github.com/lunarvim/lunarvim/pull/3268))

## [1.1.4]

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
- _(lvim/lsp/manager)_ make client_is_configured more reliable ([#2851](https://github.com/lunarvim/lunarvim/pull/2851))
- _(nvimtree)_ escape the dot character in custom filter ([#2493](https://github.com/lunarvim/lunarvim/pull/2493))
- _(nvimtree)_ make sure on_config_done is using the correct require ([#2509](https://github.com/lunarvim/lunarvim/pull/2509))
- _(nvimtree)_ add latest changes from nvimtree ([#2537](https://github.com/lunarvim/lunarvim/pull/2537))
- _(nvimtree)_ update nvim-tree setup ([#2681](https://github.com/lunarvim/lunarvim/pull/2681))
- _(nvimtree)_ remove `indent_markers` icons trailing space ([#2854](https://github.com/lunarvim/lunarvim/pull/2854))
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
- use pcall for setting up project.nvim ([#2762](https://github.com/lunarvim/lunarvim/pull/2762))

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

### <!-- 6 --> Performance

- _(cmp)_ remove redundant check for emmet-ls ([#2830](https://github.com/lunarvim/lunarvim/pull/2830))

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
