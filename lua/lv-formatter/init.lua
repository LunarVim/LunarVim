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

-- check if formatter configuration is available inside `Formatter` in default-config.lua or not
local function fmt_conf_present(lang_formatter)
  if lang_formatter == nil then
    return false
  end
  if lang_formatter.exe == nil or lang_formatter.args == nil then
    return false
  end
  return true
end

-- returns default formatter for given language. reads from `O.lang.*.formatter` in default-config.lua
local function default_formatter(formatter_list)
  for _, selected_formatter in pairs(formatter_list) do
      -- check if formatter executable is available in the system
    if (fmt_conf_present(selected_formatter) and vim.fn.executable(selected_formatter.exe)) then
        return {
          exe = selected_formatter.exe,
          args = selected_formatter.args,
          stdin = not (selected_formatter.stdin ~= nil),
        }
    end
  end
  -- if none of the formatters are available, don't format anything
  return {}
end

-- fill a table like this -> {rust: {{exe:"sth",args:{"a","b"},stdin=true}},go: {{}}...}
local formatter_filetypes = {}
for lang_name, lang_conf in pairs(O.lang) do
  if lang_conf.formatter ~= nil then
    -- if a lang has multiple filetypes, gather them all
    local lang_file_types = lang_conf.filetypes
    if lang_file_types == nil then
      lang_file_types = { lang_name }
    end
    -- set formatter for all supported file types in the language
    for _, file_type in pairs(lang_file_types) do
      formatter_filetypes[file_type] = {
        function()
          return default_formatter(lang_conf.formatter)
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
