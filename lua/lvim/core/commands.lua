local M = {}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

M.defaults = {
  {
    name = "BufferKill",
    fn = function()
      require("lvim.core.bufferline").buf_kill "bd"
    end,
  },
  {
    name = "LvimToggleFormatOnSave",
    fn = function()
      require("lvim.core.autocmds").toggle_format_on_save()
    end,
  },
  {
    name = "LvimInfo",
    fn = function()
      require("lvim.core.info").toggle_popup(vim.bo.filetype)
    end,
  },
  {
    name = "LvimDocs",
    fn = function()
      local documentation_url = "https://www.lunarvim.org/docs/quick-start"
      if vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1 then
        vim.fn.execute("!open " .. documentation_url)
      elseif vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
        vim.fn.execute("!start " .. documentation_url)
      elseif vim.fn.has "unix" == 1 then
        vim.fn.execute("!xdg-open " .. documentation_url)
      else
        vim.notify "Opening docs in a browser is not supported on your OS"
      end
    end,
  },
  {
    name = "LvimCacheReset",
    fn = function()
      require("lvim.utils.hooks").reset_cache()
    end,
  },
  {
    name = "LvimReload",
    fn = function()
      require("lvim.config"):reload()
    end,
  },
  {
    name = "LvimUpdate",
    fn = function()
      require("lvim.bootstrap"):update()
    end,
  },
  {
    name = "LvimSyncCorePlugins",
    fn = function()
      require("lvim.plugin-loader").sync_core_plugins()
    end,
  },
  {
    name = "LvimChangelog",
    fn = function()
      require("lvim.core.telescope.custom-finders").view_lunarvim_changelog()
    end,
  },
  {
    name = "LvimVersion",
    fn = function()
      print(require("lvim.utils.git").get_lvim_version())
    end,
  },
  {
    name = "LvimOpenlog",
    fn = function()
      vim.fn.execute("edit " .. require("lvim.core.log").get_path())
    end,
  },
}

function M.load(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

return M
