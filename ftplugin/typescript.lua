require("lsp").setup "typescript"
if lvim.lang.tailwindcss.active then
  require("lsp").setup "tailwindcss"
end
