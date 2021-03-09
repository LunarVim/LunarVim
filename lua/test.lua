local firstmodule = {}

function firstmodule.hello_world()
  vim.lsp.buf.definition()
end

return firstmodule
