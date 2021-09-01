local Table = {}

--- Check unary predicate returns True for at least one entry of the table.
-- @param t The table
-- @param predicate The function called for each entry of t
-- @return True if predicate returned True at least once, false otherwise
function Table.any_of(t, predicate)
  for _, entry in ipairs(t) do
    if predicate(entry) then
      return true
    end
  end
  return false
end

return Table
