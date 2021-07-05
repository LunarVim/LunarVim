if O.lang.rust.rust_tools.active then
  local opts = {
    tools = { -- rust-tools options
      -- automatically set inlay hints (type hints)
      -- There is an issue due to which the hints are not applied on the first
      -- opened file. For now, write to the file to trigger a reapplication of
      -- the hints or just run :RustSetInlayHints.
      -- default: true
      autoSetHints = true,

      -- whether to show hover actions inside the hover window
      -- this overrides the default hover handler
      -- default: true
      hover_with_actions = true,

      runnables = {
        -- whether to use telescope for selection menu or not
        -- default: true
        use_telescope = true,

        -- rest of the opts are forwarded to telescope
      },

      inlay_hints = {
        -- wheter to show parameter hints with the inlay hints or not
        -- default: true
        show_parameter_hints = true,

        -- prefix for parameter hints
        -- default: "<-"
        parameter_hints_prefix = "<-",

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = "=>",

        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,

        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,

        -- whether to align to the extreme right or not
        right_align = false,

        -- padding from the right if right_align is true
        right_align_padding = 7,
      },

      hover_actions = {
        -- the border that is used for the hover window
        -- see vim.api.nvim_open_win()
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
      },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
      cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },
      on_attach = require("lsp").common_on_attach,
    }, -- rust-analyser options
  }
  require("rust-tools").setup(opts)
else
  require("lspconfig").rust_analyzer.setup {
    cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "rust" },
    root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json"),
  }
end

-- TODO fix these mappings
vim.api.nvim_exec(
  [[
    autocmd Filetype rust nnoremap <leader>lm <Cmd>RustExpandMacro<CR>
    autocmd Filetype rust nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>
    autocmd Filetype rust nnoremap <leader>le <Cmd>RustRunnables<CR>
    autocmd Filetype rust nnoremap <leader>lh <Cmd>RustHoverActions<CR>
    ]],
  true
)
