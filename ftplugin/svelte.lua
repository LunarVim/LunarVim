require("lsp").setup "svelte"
if lvim.lang.tailwindcss.active then
  require("lsp").setup "tailwindcss"
end
