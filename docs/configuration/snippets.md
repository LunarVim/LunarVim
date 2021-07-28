# Snippets
If you need snippet support add the following to `lvim.plugins`

```
lvim.plugins = {
  {
    "hrsh7th/vim-vsnip",
    wants = "friendly-snippets",
    event = "InsertCharPre",
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre",
  },
}
```
