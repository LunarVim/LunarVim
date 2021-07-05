-- npm i -g bash-language-server
require("lspconfig").bashls.setup {
  cmd = { DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start" },
  on_attach = require("lsp").common_on_attach,
  filetypes = { "sh", "zsh" },
}

-- npm i -g bash-language-server
require("lspconfig").bashls.setup {
  cmd = { DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start" },
  on_attach = require("lsp").common_on_attach,
  filetypes = { "sh", "zsh" },
}

-- sh
local sh_arguments = {}

local shellcheck = {
  LintCommand = "shellcheck -f gcc -x",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

if O.lang.sh.linter == "shellcheck" then
  table.insert(sh_arguments, shellcheck)
end

require("lspconfig").efm.setup {
  -- init_options = {initializationOptions},
  cmd = { DATA_PATH .. "/lspinstall/efm/efm-langserver" },
  init_options = { documentFormatting = true, codeAction = false },
  filetypes = { "zsh" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      sh = sh_arguments,
    },
  },
}
