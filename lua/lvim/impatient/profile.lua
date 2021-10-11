local M = {}

local api = vim.api

function M.print_profile(profile)
  if not profile then
    print "Error: profiling was not enabled"
    return
  end

  local total_resolve = 0
  local total_load = 0
  local name_pad = 0
  local modules = {}
  local plugins = {}

  for module, p in pairs(profile) do
    p.resolve = p.resolve / 1000000
    p.load = p.load / 1000000
    p.total = p.resolve + p.load
    p.module = module:gsub("/", ".")

    local plugin = p.module:match "([^.]+)"
    if plugin then
      if not plugins[plugin] then
        plugins[plugin] = {
          module = plugin,
          resolve = 0,
          load = 0,
          total = 0,
        }
      end
      local r = plugins[plugin]

      r.resolve = r.resolve + p.resolve
      r.load = r.load + p.load
      r.total = r.total + p.total

      if not r.loader then
        r.loader = p.loader
      elseif r.loader ~= p.loader then
        r.loader = "mixed"
      end
    end

    total_resolve = total_resolve + p.resolve
    total_load = total_load + p.load

    if #module > name_pad then
      name_pad = #module
    end

    modules[#modules + 1] = p
  end

  table.sort(modules, function(a, b)
    return a.module > b.module
  end)

  do
    local plugins_a = {}
    for _, v in pairs(plugins) do
      plugins_a[#plugins_a + 1] = v
    end
    plugins = plugins_a
  end

  table.sort(plugins, function(a, b)
    return a.total > b.total
  end)

  local lines = {}
  local function add(...)
    lines[#lines + 1] = string.format(...)
  end

  local l = string.rep("─", name_pad + 1)

  add(
    "%s┬───────────┬────────────┬────────────┬────────────┐",
    l
  )
  add("%-" .. name_pad .. "s │ Loader    │ Resolve    │ Load       │ Total      │", "")
  add(
    "%s┼───────────┼────────────┼────────────┼────────────┤",
    l
  )
  add(
    "%-" .. name_pad .. "s │           │ %8.4fms │ %8.4fms │ %8.4fms │",
    "Total",
    total_resolve,
    total_load,
    total_resolve + total_load
  )
  add(
    "%s┴───────────┴────────────┴────────────┴────────────┤",
    l
  )
  add("%-" .. name_pad .. "s                                                    │", "By Plugin")
  add(
    "%s┬───────────┬────────────┬────────────┬────────────┤",
    l
  )
  for _, p in ipairs(plugins) do
    add(
      "%-" .. name_pad .. "s │ %9s │ %8.4fms │ %8.4fms │ %8.4fms │",
      p.module,
      p.loader,
      p.resolve,
      p.load,
      p.total
    )
  end
  add(
    "%s┴───────────┴────────────┴────────────┴────────────┤",
    l
  )
  add("%-" .. name_pad .. "s                                                    │", "By Module")
  add(
    "%s┬───────────┬────────────┬────────────┬────────────┤",
    l
  )
  for _, p in pairs(modules) do
    add(
      "%-" .. name_pad .. "s │ %9s │ %8.4fms │ %8.4fms │ %8.4fms │",
      p.module,
      p.loader,
      p.resolve,
      p.load,
      p.total
    )
  end
  add(
    "%s┴───────────┴────────────┴────────────┴────────────┘",
    l
  )

  local bufnr = api.nvim_create_buf(false, false)
  api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
  api.nvim_buf_set_option(bufnr, "buftype", "nofile")
  api.nvim_buf_set_name(bufnr, "Impatient Profile Report")
  api.nvim_set_current_buf(bufnr)
end

return M
