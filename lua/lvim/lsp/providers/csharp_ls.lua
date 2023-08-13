local opts = {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("*.sln")(fname)
      or util.root_pattern("*.csproj")(fname)
      or util.root_pattern("*.fsproj")(fname)
      or util.root_pattern(".git")(fname)
  end,
}

return opts
