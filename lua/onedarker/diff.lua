local diff = {
  DiffAdd = { fg = C.none, bg = C.diff_add },
  DiffDelete = { fg = C.none, bg = C.diff_delete },
  DiffChange = { fg = C.none, bg = C.diff_change, style = "bold" },
  DiffText = { fg = C.none, bg = C.diff_text },
  DiffAdded = { fg = C.green },
  DiffRemoved = { fg = C.red },
  DiffFile = { fg = C.cyan },
  DiffIndexLine = { fg = C.gray },
}

return diff
