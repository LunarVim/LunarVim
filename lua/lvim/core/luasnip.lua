local M = {}
local utils = require "lvim.utils"
local paths = {}

function M.gen_setup_snips()
  local ls = require "luasnip"
  local lua_snippets = {
    -- ls.parser.parse_snippet("cmp", utils.r_inspect_settings(lvim.builtin.cmp, "lvim.builtin.cmp", 10000, ".")),
    -- ls.parser.parse_snippet("lir", utils.r_inspect_settings(lvim.builtin.lir, "lvim.builtin.lir", 10000, ".")),
  }
  for i, v in pairs(lvim.builtin) do
    lua_snippets[#lua_snippets + 1] =
      ls.parser.parse_snippet("lvim.builtin." .. i, utils.r_inspect_settings(v, "lvim.builtin." .. i, 10000, "."))
  end
  ls.add_snippets("lua", lua_snippets)
end

function M.setup()
  if lvim.builtin.luasnip.sources.friendly_snippets then
    paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "friendly-snippets")
  end
  local user_snippets = utils.join_paths(get_config_dir(), "snippets")
  if utils.is_directory(user_snippets) then
    paths[#paths + 1] = user_snippets
  end
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load {
    paths = paths,
  }
  require("luasnip.loaders.from_snipmate").lazy_load()

  M.gen_setup_snips()
end

return M
