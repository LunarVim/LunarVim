-- About how to create snippets:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
-- uncoment nodes as you need them
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local m = extras.m
-- local rep = extras.rep
-- local postfix = require("luasnip.extras.postfix").postfix
local fmt = require("luasnip.extras.fmt").fmt
local extras = require "luasnip.extras"
local l = extras.l
local dl = extras.dynamic_lambda
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node

return {
  s(
    { trig = "preq", dscr = "Protected require call" },
    fmt(
      [[
      local ok, {} = pcall(require,'{}')
      if not ok then
        return
      end]],
      { i(1), dl(2, "lvim.core." .. l._1, 1) }
    )
  ),
}
