require("lsp").setup "css"
if lvim.lang.tailwindcss.active then
  require("lsp").setup "tailwindcss"
end
