local installer = {}

local LSP_INSTALL_DIR = DATA_PATH .. "/lspinstall"

installer.default_install_path = {
  ["sh"] = LSP_INSTALL_DIR .. "/bash/node_modules/.bin/bash-language-server",
  ["cpp"] = LSP_INSTALL_DIR .. "/cpp/clangd/bin/clangd",
  ["cmake"] = LSP_INSTALL_DIR .. "/cmake/venv/bin/cmake-language-server",
  ["csharp"] = LSP_INSTALL_DIR .. "/csharp/omnisharp/run",
  ["css"] = LSP_INSTALL_DIR .. "/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
  ["docker"] = LSP_INSTALL_DIR .. "/dockerfile/node_modules/.bin/docker-langserver",
  ["efm"] = LSP_INSTALL_DIR .. "/efm/efm-langserver",
  ["elm"] = LSP_INSTALL_DIR .. "/elm/node_modules/.bin/elm-language-server",
  ["gopls"] = LSP_INSTALL_DIR .. "/go/gopls",
  ["html"] = LSP_INSTALL_DIR .. "/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
  ["php"] = LSP_INSTALL_DIR .. "/php/node_modules/.bin/intelephense",
  ["java"] = LSP_INSTALL_DIR .. "/java/jdtls.sh",
  ["json"] = LSP_INSTALL_DIR .. "/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
  ["angular"] = LSP_INSTALL_DIR .. "/angular/node_modules/@angular/language-server/bin/ngserver",
  ["python"] = LSP_INSTALL_DIR .. "/python/node_modules/.bin/pyright-langserver",
  ["rust"] = LSP_INSTALL_DIR .. "/rust/rust-analyzer",
  ["elixir"] = LSP_INSTALL_DIR .. "/elixir/elixir-ls/language_server.sh",
  ["ruby"] = LSP_INSTALL_DIR .. "/ruby/solargraph/solargraph",
  ["lua"] = LSP_INSTALL_DIR .. "/lua",
  ["svelte"] = LSP_INSTALL_DIR .. "/svelte/node_modules/.bin/svelteserver",
  ["terraform"] = LSP_INSTALL_DIR .. "/terraform/terraform-ls",
  ["latex"] = LSP_INSTALL_DIR .. "/latex/texlab",
  ["tsserver"] = LSP_INSTALL_DIR .. "/typescript/node_modules/.bin/typescript-language-server",
  ["vim"] = LSP_INSTALL_DIR .. "/vim/node_modules/.bin/vim-language-server",
  ["vue"] = LSP_INSTALL_DIR .. "/vue/node_modules/.bin/vls",
  ["yaml"] = LSP_INSTALL_DIR .. "/yaml/node_modules/.bin/yaml-language-server",
}

function installer.get_langserver_path(lang)
  -- check if it has been defined by the user
  if O.lang[lang]["custom_languageserver"] ~= nil then
    return O.lang[lang]["custom_languageserver"]
  end
  -- otherwise we use the one provided by LspInstall if it's available
  if require("lspinstall").is_server_installed(lang) then
    return installer.default_install_path[lang]
  else
    vim.notify("No language server was found! try :LspInstall " .. lang)
  end
end

return installer
