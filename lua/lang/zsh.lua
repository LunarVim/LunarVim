local M = {}

M.config = function()
  O.lang.zsh = {
    lsp_path = DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
  }
end

M.format = function()
  -- TODO: implement format for language
  return "No format available!"
end

M.lint = function()
  -- zsh
  local zsh_arguments = {}

  if not require("lv-utils").check_lsp_client_active "efm" then
    require("lspconfig").efm.setup {
      -- init_options = {initializationOptions},
      cmd = { DATA_PATH .. "/lspinstall/efm/efm-langserver" },
      init_options = { documentFormatting = true, codeAction = false },
      root_dir = require("lspconfig").util.root_pattern ".git/",
      filetypes = { "zsh" },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          zsh = zsh_arguments,
        },
      },
    }
  end
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "bashls" then
    -- npm i -g bash-language-server
    require("lspconfig").bashls.setup {
      cmd = { O.lang.zsh.lsp_path, "start" },
      on_attach = require("lsp").common_on_attach,
      filetypes = { "sh", "zsh" },
    }
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
