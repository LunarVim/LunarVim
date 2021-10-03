local schemas = nil
local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
if status_ok then
  schemas = jsonls_settings.get_default_schemas()
end

local opts = {
  setup = {
    settings = {
      json = {
        schemas = schemas,
        --   = {
        --   {
        --     fileMatch = { "package.json" },
        --     url = "https://json.schemastore.org/package.json",
        --   },
        -- },
      },
    },
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
