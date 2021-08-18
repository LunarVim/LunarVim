require("lsp").setup "javascript"
if lvim.lang.tailwindcss.active then
  require("lsp").setup "tailwindcss"
end
