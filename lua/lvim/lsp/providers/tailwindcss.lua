local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern(
      "tailwind.config.js",
      "tailwind.config.ts",
      "tailwind.config.cjs",
      "tailwind.js",
      "tailwind.ts",
      "tailwind.cjs"
    )(fname)
  end,
}

return opts
