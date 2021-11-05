local M = {}

function M.config()
  local header = {
    type = "text",
    val = {
      [[    __                          _    ___         ]],
      [[   / /   __  ______  ____ _____| |  / (_)___ ___ ]],
      [[  / /   / / / / __ \/ __ `/ ___/ | / / / __ `__ \]],
      [[ / /___/ /_/ / / / / /_/ / /   | |/ / / / / / / /]],
      [[/_____/\__,_/_/ /_/\__,_/_/    |___/_/_/ /_/ /_/ ]],
    },
    opts = {
      hl = "Label",
      shrink_margin = false,
      -- wrap = "overflow";
    },
  }

  local top_buttons = {
    entries = {
      { keybind = "e", description = "  New File", command = "<CMD>ene!<CR>" },
    },
    val = {},
  }

  local bottom_buttons = {
    entries = {
      { keybind = "q", description = "Quit", command = "<CMD>quit<CR>" },
    },
    val = {},
  }

  local nvim_web_devicons = {
    enabled = true,
    highlight = true,
  }

  local footer = {
    type = "group",
    val = {},
  }

  return {
    header = header,
    nvim_web_devicons = nvim_web_devicons,
    top_buttons = top_buttons,
    bottom_buttons = bottom_buttons,
    -- this is probably broken
    footer = footer,
  }
end

return M
