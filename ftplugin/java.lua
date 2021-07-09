if require("lv-utils").check_lsp_client_active "jdtls" then
  return
end

if O.lang.java.java_tools.active then
  print "hi"
  -- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
  if vim.fn.has "mac" == 1 then
    JAVA_LS_EXECUTABLE = CONFIG_PATH .. "/utils/bin/java-mac-ls"
    WORKSPACE_PATH = "/Users/" .. USER .. "/workspace/"
  elseif vim.fn.has "unix" == 1 then
    JAVA_LS_EXECUTABLE = CONFIG_PATH .. "/utils/bin/java-linux-ls"
    WORKSPACE_PATH = "/home/" .. USER .. "/workspace/"
  else
    print "Unsupported system"
  end
  print(JAVA_LS_EXECUTABLE)
  print(WORKSPACE_PATH)

  require("jdtls").start_or_attach {
    cmd = { JAVA_LS_EXECUTABLE, WORKSPACE_PATH .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
  }
else
  local util = require "lspconfig/util"

  require("lspconfig").jdtls.setup {
    on_attach = require("lsp").common_on_attach,
    cmd = { DATA_PATH .. "/lspinstall/java/jdtls.sh" },
    filetypes = { "java" },
    root_dir = util.root_pattern { ".git", "build.gradle", "pom.xml" },
    -- init_options = {bundles = bundles}
    -- on_attach = require'lsp'.common_on_attach
  }
end

-- local bundles = {
--     vim.fn.glob(
--         CONFIG_PATH.."/.debuggers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
-- };

-- require('jdtls').start_or_attach({
--     on_attach = on_attach,
--     cmd = {DATA_PATH .. "/lspinstall/java/jdtls.sh"},
--     root_dir = require('jdtls.setup').find_root({'build.gradle', 'pom.xml', '.git'}),
--     init_options = {bundles = bundles}
-- })

-- TODO setup autoformat stuff later
-- _java = {
--     -- {'FileType', 'java', 'luafile '..CONFIG_PATH..'/lua/lsp/java-ls.lua'},
--     {
--         'FileType', 'java',
--         'nnoremap ca <Cmd>lua require(\'jdtls\').code_action()<CR>'
--     }
-- }
