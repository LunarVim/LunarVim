local M = {}

--- Center align lines relatively to the parent container
-- @param container The container where lines will be displayed
-- @param lines The text to align
-- @param alignment The alignment value, range: [0-1]
function M.align(container, lines, alignment)
  local max_length = 0
  for _, line in ipairs(lines) do
    local line_len = line:len()
    if line_len > max_length then
      max_length = line_len
    end
  end

  local indent_amount = math.ceil(math.max(container.width - max_length, 0) * alignment)
  return M.shift_left(lines, indent_amount)
end

--- Shift lines by a given amount
-- @params lines The lines the shift
-- @param amount The amount of spaces to add
function M.shift_left(lines, amount)
  local output = {}
  local padding = string.rep(" ", amount)

  for _, line in ipairs(lines) do
    table.insert(output, padding .. line)
  end

  return output
end

return M
