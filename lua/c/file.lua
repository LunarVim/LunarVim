--- File management
-- @module c.file

local autocmd = require("c.autocmd")

local file = {}

--- Set up auto-detection for filetypes by a name pattern (Eg: `*.cpp` -> `cpp`)
--
-- @tparam string pattern The filename pattern
-- @tparam string filetype The filetype identifier
function file.set_filetype_for(pattern, filetype)
  autocmd.bind("BufNewFile,BufRead " .. pattern, function()
    vim.bo.filetype = filetype
  end)
end

--- Add a pattern to the wildignore setting
function file.add_to_wildignore(pattern)
  if vim.o.wildignore == "" then
    vim.o.wildignore = pattern
  else
    vim.o.wildignore = vim.o.wildignore .. "," .. pattern
  end
end

--- Check if a file is readable
--
-- @tparam string path The file path
--
-- @treturn bool Whether the file exists and is readable
function file.is_readable(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

--- Make a directory
--
-- @tparam string path The directory path
-- @tparam bool make_parents Should parent directories be made? (`mkdir -p`)
function file.mkdir(path, make_parents)
  -- TODO: Replace this with not-vimscript if nvim gets better Lua fs support?
  local opts
  if make_parents then
    opts = "p"
  else
    opts = ""
  end

  vim.cmd("call mkdir('" .. path .. "', '" .. opts .. "')")
end

--- Check if a file or directory exists in this path
--
-- @tparam string path The file path
function file.exists(path)
  local ok, _, code = os.rename(path, path)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end

  return ok
end

--- Check if a directory exists in this path
--
-- @tparam string path The file path
function file.is_dir(path)
  -- "/" works on both Unix and Windows
  return file.exists(path .. "/")
end

local function is_windows()
  local path_sep = package.config:sub(1, 1)
  return path_sep == "\\"
end

--- Returns the path to the home directory
function file.get_home_dir()
  local home = os.getenv("HOME")
  if home ~= nil then return home end

  if is_windows() then
    local userprofile = os.getenv("USERPROFILE")
    if userprofile ~= nil then return userprofile end
  end

  error("Failed to get home directory")
end

return file
