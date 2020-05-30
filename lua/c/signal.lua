--- Signals
-- @module c.signal

local class = require("c.class")

local signal = {}

signal.Signal = class.strict {
  _connections = class.NULL,
  _connections_weak = class.NULL,
  _connections_once = class.NULL,

  __init = function(self)
    self._connections = {}
    self._connections_weak = {}
    self._connections_once = {}
    setmetatable(self._connections_weak, {__mode = "v"}) -- Weak values
  end,

  emit = function(self, ...)
    local results = {}

    for _, v in pairs(self._connections) do
      local ret = v(...)
      if ret ~= nil then table.insert(results, ret) end
    end

    for _, v in pairs(self._connections_weak) do
      local ret = v(...)
      if ret ~= nil then table.insert(results, ret) end
    end

    for _, v in pairs(self._connections_once) do
      local ret = v(...)
      if ret ~= nil then table.insert(results, ret) end
    end
    self._connections_once = {}

    return results
  end,

  connect = function(self, slot)
    table.insert(self._connections, slot)
  end,

  connect_weak = function(self, slot)
    table.insert(self._connections_weak, slot)
  end,

  connect_once = function(self, slot)
    table.insert(self._connections_once, slot)
  end,

  disconnect = function(self, slot)
    -- Iterate backwards because we remove stuff from the table while iterating
    for i = #self._connections, 1, -1 do
      local obj = self._connections[i]
      if obj == slot then
        table.remove(self._connections, i)
      end
    end

    for i = #self._connections_weak, 1, -1 do
      local obj = self._connections_weak[i]
      if obj == slot then
        table.remove(self._connections_weak, i)
      end
    end
  end,
}

return signal
