local M = {}

local function max_len_line(lines)
  local max_len = 0

  for _, line in ipairs(lines) do
    local line_len = line:len()
    if line_len > max_len then
      max_len = line_len
    end
  end

  return max_len
end

--- Left align lines relatively to the parent container
-- @param container The container where lines will be displayed
-- @param lines The text to align
-- @param alignment The alignment value, range: [0-1]
function M.align_left(container, lines, alignment)
  local max_len = max_len_line(lines)
  local indent_amount = math.ceil(math.max(container.width - max_len, 0) * alignment)
  return M.shift_right(lines, indent_amount)
end

--- Center align lines relatively to the parent container
-- @param container The container where lines will be displayed
-- @param lines The text to align
-- @param alignment The alignment value, range: [0-1]
function M.align_center(container, lines, alignment)
  local output = {}
  local max_len = max_len_line(lines)

  for _, line in ipairs(lines) do
    local padding = string.rep(" ", (math.max(container.width, max_len) - line:len()) * alignment)
    table.insert(output, padding .. line)
  end

  return output
end

--- Shift lines by a given amount
-- @params lines The lines the shift
-- @param amount The amount of spaces to add
function M.shift_right(lines, amount)
  local output = {}
  local padding = string.rep(" ", amount)

  for _, line in ipairs(lines) do
    table.insert(output, padding .. line)
  end

  return output
end

--- Pretty format tables
-- @param entries The table to format
-- @param col_count The number of column to span the table on
-- @param col_sep The separator between each colummn, default: " "
function M.format_table(entries, col_count, col_sep)
  col_sep = col_sep or " "

  local col_rows = math.ceil(vim.tbl_count(entries) / col_count)
  local cols = {}
  local count = 0

  for i, entry in ipairs(entries) do
    if ((i - 1) % col_rows) == 0 then
      table.insert(cols, {})
      count = count + 1
    end
    table.insert(cols[count], entry)
  end

  local col_max_len = {}
  for _, col in ipairs(cols) do
    table.insert(col_max_len, max_len_line(col))
  end

  local output = {}
  for i, col in ipairs(cols) do
    for j, entry in ipairs(col) do
      if not output[j] then
        output[j] = entry
      else
        local padding = string.rep(" ", col_max_len[i - 1] - cols[i - 1][j]:len())
        output[j] = output[j] .. padding .. col_sep .. entry
      end
    end
  end

  return output
end

return M
