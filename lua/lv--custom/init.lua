-- Use this to isolate your own plugins and settings.
return {
    -- used to set global options `opts.O`
    configure = function(opts)
        -- print('BEGIN configure')
    end,

    -- set vim settings before other settings
    pre_settings = function(_opts)
        --print('BEGIN pre_settings')
    end,

    -- set vim settings after other settings
    post_settings = function(_opts)
        --print('BEGIN post_settings')
    end,

    -- install your own plugins
    plugins = function(use, _opts)
        -- clipboad works across vim sessions w/o needing xsel
        -- use {'kana/vim-fakeclip'}

        -- integration w/ tmux
        -- use {'roxma/vim-tmux-clipboard'}
    end
}

