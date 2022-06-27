local full_schemas = vim.tbl_deep_extend(
  "force",
  require("schemastore").json.schemas(),
  require("nlspsettings.loaders.json").get_default_schemas()
)
local opts = {
  settings = {
    json = {
      schemas = full_schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

return opts
