if #vim.api.nvim_list_uis() ~= 0 then
  return
end

-- Try to prevent echom from cutting messages off or prompting
vim.o.shortmess = ""
vim.o.more = false
vim.o.cmdheight = 9999
vim.o.columns = 9999

vim.fn.stdioopen(vim.empty_dict())

-- override stdout functions to get newlines without triggering a prompt
-- https://github.com/neovim/neovim/issues/9358
-- luacheck: ignore print
print = function(...)
  local strings = {}
  for _, val in ipairs { ... } do
    table.insert(strings, tostring(val))
  end

  vim.schedule(function()
    vim.fn.chansend(1, { table.concat(strings, " "), "" })
  end)
end

vim.api.nvim_echo = function(chunks, _, _)
  local strings = {}
  for _, val in ipairs(chunks) do
    table.insert(strings, val[1])
  end

  vim.schedule(function()
    vim.fn.chansend(1, { table.concat(strings, ""), "" })
  end)
end
