local M = {}

-- M.config = function()
--   lvim.builtin.test = {
--     active = true,
--   }
-- end

-- local function config_test()
--   -- https://github.com/vim-test/vim-test
--   vim.api.nvim_exec(
--     [[
--         " Test config
--         let test#strategy = "neovim"
--         let test#neovim#term_position = "belowright"
--         let g:test#preserve_screen = 1
--         let g:test#echo_command = 1
--         " Python
--         let test#python#runner = 'djangotest'
--         let test#python#djangotest#options = "--keepdb --noinput"
--         " Javascript
--         let g:test#javascript#runner = 'ngtest'
--         let g:test#javascript#cypress#executable = 'npx cypress run'
--         " csharp
--         let test#csharp#runner = 'dotnettest'
--     ]],
--     false
--   )
-- end

M.setup = function()
  local status_ok, neotest = pcall(require, "neotest")
  if not status_ok then
    return
  end
  neotest.setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
      }),
      -- require "neotest-jest",
      -- require "neotest-go",
      -- require("neotest-plenary"),
      require("neotest-vim-test")({
        ignore_file_types = { "python", "vim", "lua" },
      }),
      -- require "neotest-rust",
    },
    -- overseer.nvim
    -- consumers = {
    --   overseer = require("neotest.consumers.overseer"),
    -- },
    -- overseer = {
    --   enabled = true,
    --   force_default = true,
    -- },
    discovery = {
      enabled = true,
    },
    running = {
      concurrent = false,
    },
  })
  lvim.builtin.which_key.mappings["t"] = {
    name = "Test",
    a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
    F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
    l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
    L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
    n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
    N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
    S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
    s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
    v = { "<cmd>TestVisit<cr>", "Visit" },
    x = { "<cmd>TestSuite<cr>", "Suite" },
  }

  -- vim-test
  -- config_test()
end

return M
