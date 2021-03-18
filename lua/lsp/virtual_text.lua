local virtual_text = {}

virtual_text.show = true

virtual_text.toggle = function()
    virtual_text.show = not virtual_text.show
    vim.lsp.diagnostic.display(
        vim.lsp.diagnostic.get(0, 1),
        0,
        1,
        {virtual_text = virtual_text.show}
    )
end

return virtual_text
