local uv = vim.loop
local home_dir = uv.os_homedir()

describe("initial start", function()
  before_each(function()
    vim.cmd [[
     let v:errmsg = ""
      let v:errors = []
    ]]
  end)

  after_each(function()
    local errmsg = vim.fn.eval "v:errmsg"
    local exception = vim.fn.eval "v:exception"
    local errors = vim.fn.eval "v:errors"
    assert.equal("", errmsg)
    assert.equal("", exception)
    assert.True(vim.tbl_isempty(errors))
  end)

  local lvim_config_path = get_config_dir()
  local lvim_runtime_path = get_runtime_dir()
  local lvim_cache_path = get_cache_dir()

  it("should be able to detect test environment", function()
    assert.truthy(os.getenv "LVIM_TEST_ENV")
    assert.falsy(package.loaded["lvim.impatient"])
  end)

  it("should be able to use lunarvim cache directory using vim.fn", function()
    assert.equal(lvim_cache_path, vim.fn.stdpath "cache")
  end)

  it("should be to retrieve default neovim directories", function()
    local xdg_config = os.getenv "XDG_CONFIG_HOME" or join_paths(home_dir, ".config")
    assert.equal(join_paths(xdg_config, "nvim"), vim.call("stdpath", "config"))
  end)

  it("should be able to read lunarvim directories", function()
    local rtp_list = vim.opt.rtp:get()
    assert.truthy(vim.tbl_contains(rtp_list, lvim_runtime_path .. "/lvim"))
    assert.truthy(vim.tbl_contains(rtp_list, lvim_config_path))
  end)

  it("should be able to run treesitter without errors", function()
    assert.truthy(vim.treesitter.highlighter.active)
  end)

  it("should be able to pass basic checkhealth without errors", function()
    vim.cmd "set cmdheight&"
    vim.cmd "silent checkhealth nvim"
    local errmsg = vim.fn.eval "v:errmsg"
    local exception = vim.fn.eval "v:exception"
    assert.equal("", errmsg) -- v:errmsg was not updated.
    assert.equal("", exception)
  end)
end)
