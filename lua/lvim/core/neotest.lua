local M = {}

M.config = function()
  lvim.builtin.test = {
    active = false,
  }
end


M.setup = function(config)
  local status_ok, neotest = pcall(require, "neotest")
  if not status_ok then
    return
  end

  if vim.tbl_isempty(config) then
    return
  end

  neotest.setup(config)
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
  }
end

return M
