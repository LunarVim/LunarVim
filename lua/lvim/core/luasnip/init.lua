local M = {}
function M.config()
  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
      lunarvim = true,
    },
    config = {
      updateevents = "TextChanged,TextChangedI",
      ext_opts = {
        -- Will be populated within config function
      },
    },
  }
end

function M.setup()
  local utils = require "lvim.utils"
  local paths = {}
  if lvim.builtin.luasnip.sources.friendly_snippets then
    paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "packer", "start", "friendly-snippets")
  end
  local user_snippets = utils.join_paths(get_config_dir(), "snippets")
  if utils.is_directory(user_snippets) then
    paths[#paths + 1] = user_snippets
  end
  -- When no paths are provided, luasnip will search in the runtimepath
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load {
    paths = paths,
  }
  require("luasnip.loaders.from_snipmate").lazy_load()

  local luasnip = require "luasnip"
  local types = require "luasnip.util.types"

  local ext_opts = {
    -- Show virtual text to signal when you are inside an sippets
    [types.insertNode] = {
      active = {
        virt_text = { { "<-- snip insert", "BufferInactiveIndex" } },
      },
    },
    -- Helps to notice when you are within a choice node
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-- choice", "BufferInactiveIndex" } },
      },
    },
  }
  -- Add lunarvim options giving preference to user ones
  vim.tbl_deep_extend("keep", lvim.builtin.luasnip.config.ext_opts, ext_opts)
  luasnip.config.set_config(lvim.builtin.luasnip.config)
  if lvim.builtin.luasnip.sources.lunarvim then
    luasnip.add_snippets("lua", require "lvim.core.luasnip.snippets")
  end
end
return M
