require("lsp").setup "html"
if lvim.lang.tailwindcss.active then
  require("lsp").setup "tailwindcss"
end
