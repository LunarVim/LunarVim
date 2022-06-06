local M = {}

local api, uv = vim.api, vim.loop

local std_data = vim.fn.stdpath "data"
local std_config = vim.fn.stdpath "config"
local vimruntime = os.getenv "VIMRUNTIME"
local lvim_runtime = get_runtime_dir()
local lvim_config = get_config_dir()

local function load_buffer(title, lines)
  local bufnr = api.nvim_create_buf(false, false)
  api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
  api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  api.nvim_buf_set_option(bufnr, "buftype", "nofile")
  api.nvim_buf_set_option(bufnr, "swapfile", false)
  api.nvim_buf_set_option(bufnr, "modifiable", false)
  api.nvim_buf_set_name(bufnr, title)
  api.nvim_set_current_buf(bufnr)
end

local function mod_path(path)
  if not path then
    return "?"
  end
  path = path:gsub(std_data .. "/site/pack/packer/", "<PACKER>/")
  path = path:gsub(std_data .. "/", "<STD_DATA>/")
  path = path:gsub(std_config .. "/", "<STD_CONFIG>/")
  path = path:gsub(vimruntime .. "/", "<VIMRUNTIME>/")
  path = path:gsub(lvim_runtime .. "/", "<LVIM_RUNTIME>/")
  path = path:gsub(lvim_config .. "/", "<LVIM_CONFIG>/")
  return path
end

local function time_tostr(x)
  if x == 0 then
    return "?"
  end
  return string.format("%8.3fms", x)
end

local function mem_tostr(x)
  local unit = ""
  for _, u in ipairs { "K", "M", "G" } do
    if x < 1000 then
      break
    end
    x = x / 1000
    unit = u
  end
  return string.format("%1.1f%s", x, unit)
end

function M.print_profile(I)
  local mod_profile = I.modpaths.profile
  local chunk_profile = I.chunks.profile

  if not mod_profile and not chunk_profile then
    print "Error: profiling was not enabled"
    return
  end

  local total_resolve = 0
  local total_load = 0
  local modules = {}

  for path, m in pairs(chunk_profile) do
    m.load = m.load_end - m.load_start
    m.load = m.load / 1000000
    m.path = mod_path(path)
  end

  local module_content_width = 0

  for module, m in pairs(mod_profile) do
    m.resolve = 0
    if m.resolve_end then
      m.resolve = m.resolve_end - m.resolve_start
      m.resolve = m.resolve / 1000000
    end

    m.module = module:gsub("/", ".")
    m.loader = m.loader or m.loader_guess

    local path = I.modpaths.cache[module]
    local path_prof = chunk_profile[path]
    m.path = mod_path(path)

    if path_prof then
      chunk_profile[path] = nil
      m.load = path_prof.load
      m.ploader = path_prof.loader
    else
      m.load = 0
      m.ploader = "NA"
    end

    total_resolve = total_resolve + m.resolve
    total_load = total_load + m.load

    if #module > module_content_width then
      module_content_width = #module
    end

    modules[#modules + 1] = m
  end

  table.sort(modules, function(a, b)
    return (a.resolve + a.load) > (b.resolve + b.load)
  end)

  local paths = {}

  local total_paths_load = 0
  for _, m in pairs(chunk_profile) do
    paths[#paths + 1] = m
    total_paths_load = total_paths_load + m.load
  end

  table.sort(paths, function(a, b)
    return a.load > b.load
  end)

  local lines = {}
  local function add(fmt, ...)
    local args = { ... }
    for i, a in ipairs(args) do
      if type(a) == "number" then
        args[i] = time_tostr(a)
      end
    end

    lines[#lines + 1] = string.format(fmt, unpack(args))
  end

  local time_cell_width = 12
  local loader_cell_width = 11
  local time_content_width = time_cell_width - 2
  local loader_content_width = loader_cell_width - 2
  local module_cell_width = module_content_width + 2

  local tcwl = string.rep("─", time_cell_width)
  local lcwl = string.rep("─", loader_cell_width)
  local mcwl = string.rep("─", module_cell_width + 2)

  local n = string.rep("─", 200)

  local module_cell_format = "%-" .. module_cell_width .. "s"
  local loader_format = "%-" .. loader_content_width .. "s"
  local line_format = "%s │ %s │ %s │ %s │ %s │ %s"

  local row_fmt = line_format:format(
    " %" .. time_content_width .. "s",
    loader_format,
    "%" .. time_content_width .. "s",
    loader_format,
    module_cell_format,
    "%s"
  )

  local title_fmt = line_format:format(
    " %-" .. time_content_width .. "s",
    loader_format,
    "%-" .. time_content_width .. "s",
    loader_format,
    module_cell_format,
    "%s"
  )

  local title1_width = time_cell_width + loader_cell_width - 1
  local title1_fmt = ("%s │ %s │"):format(" %-" .. title1_width .. "s", "%-" .. title1_width .. "s")

  add "Note: this report is not a measure of startup time. Only use this for comparing"
  add "between cached and uncached loads of Lua modules"
  add ""

  add "Cache files:"
  for _, f in ipairs { I.chunks.path, I.modpaths.path } do
    local size = vim.loop.fs_stat(f).size
    add("  %s %s", f, mem_tostr(size))
  end
  add ""

  add("%s─%s┬%s─%s┐", tcwl, lcwl, tcwl, lcwl)
  add(title1_fmt, "Resolve", "Load")
  add("%s┬%s┼%s┬%s┼%s┬%s", tcwl, lcwl, tcwl, lcwl, mcwl, n)
  add(title_fmt, "Time", "Method", "Time", "Method", "Module", "Path")
  add("%s┼%s┼%s┼%s┼%s┼%s", tcwl, lcwl, tcwl, lcwl, mcwl, n)
  add(row_fmt, total_resolve, "", total_load, "", "Total", "")
  add("%s┼%s┼%s┼%s┼%s┼%s", tcwl, lcwl, tcwl, lcwl, mcwl, n)
  for _, p in ipairs(modules) do
    add(row_fmt, p.resolve, p.loader, p.load, p.ploader, p.module, p.path)
  end
  add("%s┴%s┴%s┴%s┴%s┴%s", tcwl, lcwl, tcwl, lcwl, mcwl, n)

  if #paths > 0 then
    add ""
    add(n)
    local f3 = " %" .. time_content_width .. "s │ %" .. loader_content_width .. "s │ %s"
    add "Files loaded with no associated module"
    add("%s┬%s┬%s", tcwl, lcwl, n)
    add(f3, "Time", "Loader", "Path")
    add("%s┼%s┼%s", tcwl, lcwl, n)
    add(f3, total_paths_load, "", "Total")
    add("%s┼%s┼%s", tcwl, lcwl, n)
    for _, p in ipairs(paths) do
      add(f3, p.load, p.loader, p.path)
    end
    add("%s┴%s┴%s", tcwl, lcwl, n)
    add ""
  end

  load_buffer("Impatient Profile Report", lines)
end

M.setup = function(profile)
  local _require = require

  -- luacheck: ignore 121
  require = function(mod)
    local basename = mod:gsub("%.", "/")
    if not profile[basename] then
      profile[basename] = {}
      profile[basename].resolve_start = uv.hrtime()
      profile[basename].loader_guess = "C"
    end
    return _require(mod)
  end

  -- Add profiling around all the loaders
  local pl = package.loaders
  for i = 1, #pl do
    local l = pl[i]
    pl[i] = function(mod)
      local basename = mod:gsub("%.", "/")
      profile[basename].loader_guess = i == 1 and "preloader" or "loader #" .. i
      return l(mod)
    end
  end
end

return M
