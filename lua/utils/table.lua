local Table = {}

--- Check if the predicate returns True for at least one entry of the table.
-- @param t The table
-- @param predicate The function called for each entry of t
-- @return True if predicate returned True at least once, false otherwise
function Table.any_of(t, predicate)
  local index, entry = next(t)
  while entry do
    if predicate(entry) then
      return true
    end
    index, entry = next(t, index)
  end
  return false
end

--- Search for an element for which the predicate returns true.
-- @param t The table
-- @param predicate The function called for each entry of t
-- @return The entry for which the predicate returned True or nil
function Table.find_if(t, predicate)
  local index, entry = next(t)
  while entry do
    if predicate(entry) then
      return entry
    end
    index, entry = next(t, index)
  end
  return nil
end

return Table
