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
formatter_filetypes = {}
for k, v in pairs(O.lang) do
  if v.formatter ~= nil then
    if v.formatter.exe ~=nil and v.formatter.args ~= nil then
      formatter_filetypes[k]={
        function ()
          return {
              exe = v.formatter.exe,
              args = v.formatter.args,
              stdin = true,
          }
        end
      }
    end
  end
end
require('formatter').setup({
  logging = false,
  filetype = formatter_filetypes,
})

if not O.format_on_save then
  if vim.fn.exists('#autoformat#BufWritePre') then
    vim.cmd [[ :autocmd! autoformat ]]
  end
end
