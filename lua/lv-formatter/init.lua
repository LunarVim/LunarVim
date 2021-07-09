-- autoformat
if O.format_on_save then
  require("lv-utils").define_augroups {
    autoformat = {
      {
        "BufWritePost",
        "*",
        "FormatWrite",
      },
    },
  }
end
-- returns default formatter for given language
function formatter_return(lang_formatter)
  return {
    exe = lang_formatter.exe,
    args = lang_formatter.args,
    stdin = not (lang_formatter.stdin ~= nil),
  }
end

formatter_filetypes = {}
for k, v in pairs(O.lang) do
  if v.formatter ~= nil then
    if v.formatter.exe ~= nil and v.formatter.args ~= nil then
      if v.filetypes ~= nil then
        for _, l in pairs(v.filetypes) do
          formatter_filetypes[l] = {
            function()
              return formatter_return(v.formatter)
            end,
          }
        end
      else
        formatter_filetypes[k] = {
          function()
            return formatter_return(v.formatter)
          end,
        }
      end
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
