local M = {}
local utils = require "lvim.utils"
local paths = {}

vim.api.nvim_create_autocmd("User", {
  pattern = "LuasnipPreExpand",
  callback = function()
    local snippet = require("luasnip").session.event_node
    local dscr = snippet.dscr[1]
    local docstring = snippet.docstring[1]

    if string.find(dscr, "lvim") and docstring == "" then
      M.gen_setup_snip(dscr)
    end
  end,
})

function M.init_empty_setup_snips()
  local ls = require "luasnip"
  for i, _ in pairs(lvim.builtin) do
    local lua_snippet = { ls.parser.parse_snippet("lvim.builtin." .. i, "") }
    ls.add_snippets("lua", lua_snippet, { key = "lvim.builtin." .. i })
  end
end

function M.gen_setup_snip(structure_str)
  local ls = require "luasnip"
  local structure_split = vim.split(structure_str, "%.")
  local structure = lvim.builtin[structure_split[3]]
  local lua_snippet =
    ls.parser.parse_snippet(structure_str, utils.r_inspect_settings(structure, structure_str, 10000, "."))
  ls.add_snippets("lua", { lua_snippet }, { key = structure_str })
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

  M.init_empty_setup_snips()
end

return M
