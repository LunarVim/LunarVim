local M = {}
local Log = require "lvim.core.log"

M.config = function()
  lvim.builtin.noice = {
    active = true,
    on_config_done = nil,
    options = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true, --lvim.builtin.noice.active,
          ["vim.lsp.util.stylize_markdown"] = true, --lvim.builtin.noice.active,
          ["cmp.entry.get_documentation"] = true, --lvim.builtin.noice.active,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "single",
            color = { fg = "#FF0000", bg = "#FF0000" }
          }
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    }
  }
end

M.setup = function()
  local noice_ok, noice = pcall(require, "noice")
  if noice_ok then
    noice.setup(lvim.builtin.noice.options)
  else
    Log:error("Failed to load noice")
    return
  end

  if lvim.builtin.noice.on_config_done then
    lvim.builtin.noice.on_config_done()
  end
end

-- " "

return M
