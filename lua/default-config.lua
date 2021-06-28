CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

O = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'lunar',
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = true,
    cursorline = true,
    shell = 'bash',
    timeoutlen = 100,
    nvim_tree_disable_netrw = 0,
    extras = false,

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = "all",
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        playground = {enabled = true},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},

    plugin = {
        hop = {active = false},
        dial = {active = false},
        dashboard = {active = false},
        matchup = {active = false}


    },

    lang = {
        python = {
            active = false,
            linter = '',
            -- @usage can be 'yapf', 'black'
            formatter = '',
            autoformat = false,
            isort = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            },
            analysis = {
                type_checking = "basic",
                auto_search_paths = true,
                use_library_code_types = true
            }
        },
        dart = {
            active = false,
            sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'
        },
        lua = {
            active = false,
            -- @usage can be 'lua-format'
            formatter = '',
            autoformat = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        sh = {
            active = false,
            -- @usage can be 'shellcheck'
            linter = '',
            -- @usage can be 'shfmt'
            formatter = '',
            autoformat = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        tsserver = {
            active = false,
            -- @usage can be 'eslint'
            linter = '',
            -- @usage can be 'prettier'
            formatter = '',
            autoformat = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        json = {
            active = false,
            -- @usage can be 'prettier'
            formatter = '',
            autoformat = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        tailwindcss = {
            active = false,
            filetypes = {
                'html', 'css', 'scss', 'javascript', 'javascriptreact',
                'typescript', 'typescriptreact'
            }
        },
        clang = {
            active = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        ruby = {
            active = false,
            diagnostics = {
                virtualtext = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            },
            filetypes = {'rb', 'erb', 'rakefile'}
        },
        go = {active = false},
        elixer = {active = false},
        vim = {active = false},
        yaml = {active = false},
        terraform = {active = false},
        rust = {
            active = false,
            linter = '',
            formatter = '',
            autoformat = false,
            diagnostics = {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true
            }
        },
        svelte = {active = false},
        php = {active = false},
        latex = {active = false},
        kotlin = {active = false},
        html = {active = false},
        elm = {active = false},
        emmet = {active = false},
        graphql = {active = false},
        efm = {active = true},
        docker = {active = false},
        cmake = {active = false},
        java = {active = false},
        css = {
            active = false,

            formatter = '',
            autoformat = false,
            virtual_text = true
        }

    },

    dashboard = {
        custom_header = {
            '                 _..._                                                                           ',
            '               .\'   (_`.    _                         __     ___           ',
            '              :  .      :  | |   _   _ _ __   __ _ _ _\\ \\   / (_)_ __ ___  ',
            '              :)    ()  :  | |  | | | | \'_ \\ / _` | \'__\\ \\ / /| | \'_ ` _ \\ ',
            '              `.   .   .\'  | |__| |_| | | | | (_| | |   \\ V / | | | | | | |',
            '                `-...-\'    |_____\\__,_|_| |_|\\__,_|_|    \\_/  |_|_| |_| |_|'
        },
        footer = {'chrisatmachine.com'}
    }
}

