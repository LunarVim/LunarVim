-- autoformat
if O.format_on_save then
  require("lv-utils").define_augroups {
    autoformat = {
      {
        "BufWritePost",
        "*",
        ":silent FormatWrite",
      },
    },
  }
end

-- check if formatter has been defined for the language or not
local function formatter_exists(lang_formatter)
  if lang_formatter == nil then
    return false
  end
  if lang_formatter.exe == nil or lang_formatter.args == nil then
    return false
  end
  return true
end

-- returns default formatter for given language
local function formatter_return(formatter_list)
  for _, selected_formatter in pairs(formatter_list) do
    if formatter_exists(selected_formatter) then
      if vim.fn.executable(selected_formatter.exe) == 1 then
        return {
          exe = selected_formatter.exe,
          args = selected_formatter.args,
          stdin = not (selected_formatter.stdin ~= nil),
        }
      end
    end
  end
  return {}
end

-- fill a table like this -> {rust: {{exe:"sth",args:{"a","b"},stdin=true}},go: {{}}...}
local formatter_filetypes = {}
for k, v in pairs(O.lang) do
  if v.formatter ~= nil then
    local keys = v.filetypes
    if keys == nil then
      keys = { k }
    end
    for _, l in pairs(keys) do
      formatter_filetypes[l] = {
        function()
          return formatter_return(v.formatter)
        end,
      }
    end
  end
end

require("formatter").setup {
  logging = false,
  filetype = formatter_filetypes,
}

if not O.format_on_save then
  vim.cmd [[if exists('#autoformat#BufWritePost')
	:autocmd! autoformat
	endif]]
end
