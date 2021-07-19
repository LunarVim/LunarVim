local M = {}

M.config = function()
  O.lang.clang = {
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    cross_file_rename = true,
    header_insertion = "never",
    filetypes = { "c", "cpp", "objc" },
    formatter = {
      exe = "clang-format",
      args = {},
      stdin = true,
    },
    linters = {
      "cppcheck",
      "clangtidy",
    },
    debug = {
      adapter = {
        command = "/usr/bin/lldb-vscode",
      },
      stop_on_entry = false,
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
    },
  }
end

M.format = function()
  local shared_config = {
    function()
      return {
        exe = O.lang.clang.formatter.exe,
        args = O.lang.clang.formatter.args,
        stdin = O.lang.clang.formatter.stdin,
        cwd = vim.fn.expand "%:h:p",
      }
    end,
  }
  O.formatters.filetype["c"] = shared_config
  O.formatters.filetype["cpp"] = shared_config
  O.formatters.filetype["objc"] = shared_config

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  require("lint").linters_by_ft = {
    c = O.lang.clang.linters,
    cpp = O.lang.clang.linters,
  }
end

M.lsp = function()
  if require("utils").check_lsp_client_active "clangd" then
    return
  end
  local clangd_flags = { "--background-index" }

  if O.lang.clang.cross_file_rename then
    table.insert(clangd_flags, "--cross-file-rename")
  end

  table.insert(clangd_flags, "--header-insertion=" .. O.lang.clang.header_insertion)

  require("lspconfig").clangd.setup {
    cmd = { O.lang.clang.lsp.path, unpack(clangd_flags) },
    on_attach = require("lsp").common_on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = O.lang.clang.diagnostics.virtual_text,
        signs = O.lang.clang.diagnostics.signs,
        underline = O.lang.clang.diagnostics.underline,
        update_in_insert = true,
      }),
    },
  }
end

M.dap = function()
  if O.plugin.dap.active then
    local dap_install = require "dap-install"
    local dap = require "dap"
    dap_install.config("ccppr_vsc_dbg", {})
    dap.adapters.lldb = {
      type = "executable",
      command = O.lang.clang.debug.adapter.command,
      name = "lldb",
    }
    local shared_dap_config = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = O.lang.clang.debug.stop_on_entry,
        args = {},
        env = function()
          local variables = {}
          for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, string.format("%s=%s", k, v))
          end
          return variables
        end,
        runInTerminal = false,
      },
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "Attach to process",
        type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = "attach",
        pid = function()
          local output = vim.fn.system { "ps", "a" }
          local lines = vim.split(output, "\n")
          local procs = {}
          for _, line in pairs(lines) do
            -- output format
            --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
            local parts = vim.fn.split(vim.fn.trim(line), " \\+")
            local pid = parts[1]
            local name = table.concat({ unpack(parts, 5) }, " ")
            if pid and pid ~= "PID" then
              pid = tonumber(pid)
              if pid ~= vim.fn.getpid() then
                table.insert(procs, { pid = tonumber(pid), name = name })
              end
            end
          end
          local choices = { "Select process" }
          for i, proc in ipairs(procs) do
            table.insert(choices, string.format("%d: pid=%d name=%s", i, proc.pid, proc.name))
          end
          local choice = vim.fn.inputlist(choices)
          if choice < 1 or choice > #procs then
            return nil
          end
          return procs[choice].pid
        end,
        args = {},
      },
    }
    dap.configurations.c = shared_dap_config
    dap.configurations.cpp = shared_dap_config
  end
end

return M
