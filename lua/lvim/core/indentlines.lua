local M = {}

M.config = function()
  lvim.builtin.indentlines = {
    active = true,
    on_config_done = nil,
    options = {
      enabled = true,
      debounce = 200,
      viewport_buffer = {
        min = 30,
        max = 500,
      },
      indent = {
        char = lvim.icons.ui.LineLeft,
        tab_char = nil,
        highlight = "IblIndent",
        smart_indent_cap = true,
        priority = 1,
      },
      whitespace = {
        highlight = "IblWhitespace",
        remove_blankline_trail = true,
      },
      exclude = {
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
        filetypes = {
          "NvimTree",
          "Trouble",
          "dashboard",
          "help",
          "lazy",
          "neogitstatus",
          "startify",
          "text",
        },
      },
      scope = {
        enabled = true,
        char = lvim.icons.ui.LineLeft,
        show_start = true,
        show_end = true,
        show_exact_scope = false,
        injected_languages = true,
        highlight = "IblScope",
        priority = 1024,
        include = {
          node_type = {},
        },
        exclude = {
          language = {},
          node_type = {
            ["*"] = {
              "source_file",
              "program",
            },
            lua = {
              "chunk",
            },
            python = {
              "module",
            },
          },
        },
      },
    },
  }
end

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

  local _, err = pcall(indent_blankline.setup, lvim.builtin.indentlines.options)

  if err then
    local invalid_key = err:match "'(.*)'"

    vim.notify(
      "`lvim.builtin.indentlines.options."
        .. invalid_key
        .. "` has been deprecated. Please take a look at `:h ibl.config` to learn about new config and update."
    )
  end

  if lvim.builtin.indentlines.on_config_done then
    lvim.builtin.indentlines.on_config_done()
  end
end

return M
