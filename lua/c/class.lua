--- A potentially over-engineered class system for Lua
-- @module c.class

local function type_instance_of(a, b)
  if a == b then return true end

  for _, v in pairs(a.__parents) do
    if type_instance_of(v, b) then return true end
  end

  return false
end

--- All class types will be inherited from `BaseType`
local BaseType = {}

--- Members of a type
BaseType.__members = {}

--- Properties of a type
BaseType.__properties = {}

--- The class type object for this type
--
-- <br>
-- Instances of this class can get the type object via the `__type` field
BaseType.__members.__type = BaseType

--- Whether the class is strict or not
--
-- <br>
-- Strict classes will error when trying to read from/write to undeclared members<br>
-- `BaseType` is not strict
BaseType.__strict = false

--- Constructor for a new object
--
-- <br>
-- The default constructor in `BaseType` takes no args and has no functionality<br>
-- Other classes can override `__init` and add their own args<br>
-- Note that `self` is the first arg passed to this method
--
-- @usage
-- local class = require("class")
--
-- local Vec3
-- Vec3 = class {
--   __init = function(self, x, y, z)
--     self.x = x or 0
--     self.y = y or 0
--     self.z = z or 0
--   end,
-- }
--
-- local v = Vec3(1, 2, 3)
BaseType.__members.__init = function() end

--- Check if an object's type is other or derived from other
--
-- @param self The instance to check
-- @param other The class type table to see if self is derived from
--
-- @usage
-- local class = require("class")
--
-- local A = class {}
-- local B = class {}
-- local C = class(A, B) {}
-- local D = class(C) {}
--
-- local inst = D()
-- print(inst:__instance_of(A)) -- true
-- print(class.instance_of(inst, A)) -- true
BaseType.__members.__instance_of = function(self, other)
  -- Check if exact same type
  if self.__type == other then return true end

  -- Check if self.__type has any parents that are of other.__type
  for _, v in pairs(self.__type.__parents) do
    if type_instance_of(v, other) then return true end
  end

  return false
end

--- Classes that this type inherits from
--
-- <br>
-- `BaseType` has no parents
BaseType.__parents = {}

-- Unique flags
local class_flag = {}
local class_property_flag = {}

--- It's like `nil` but not also used for missing-field access
--
-- <br>
-- This table is empty and only serves as a unique flag
local NULL = {}
setmetatable(
  NULL,
  {
    -- __index = function(t, k)
    --   error("Tried to read property '" .. tostring(k) .. "' from NULL")
    -- end,

    __newindex = function(t, k, v)
      error("Tried to write '" .. tostring(v) .. "' to property '" .. tostring(k) .. "' from NULL")
    end,
  }
)

--- Define custom getter and setter methods for a property, which do not need to be called explicitly
--
-- <br>
-- Eg: using `object.temperature = 25` and `print(object.temperature)` will call the getter and setters for you
--
-- @param args A table containing `get` and `set` functions
-- @param args.get A getter function that takes `(self)` and returns a value
-- @param args.set A setter function that takes `(self, new)` and is expected to use `new` to set a field
--
-- @usage
-- local class = require("class")
--
-- local City
-- City = class {
--   -- Converts to/from the stored celsius value
--   temperature_farenheit = class.property {
--     get = function(self) return (self.temperature_celsius * 9 / 5) + 32 end,
--     set = function(self, new) self.temperature_celsius = (new - 32) * 5 / 9 end,
--   },
--
--   __init = function(self)
--     self.temperature_celsius = 15
--   end,
-- }
--
-- local london = City()
-- print(london.temperature_celsius) -- 15
-- print(london.temperature_farenheit) -- 59
-- london.temperature_farenheit = 86
-- print(london.temperature_celsius) -- 30
-- print(london.temperature_farenheit) -- 86
--
-- @raise
-- - "property requires a 'get' function"
-- - "property requires a 'set' function"
local function property(args)
  if not (args.get and type(args.get) == "function") then
    error("property requires a 'get' function", 2)
  end
  if not (args.set and type(args.set) == "function") then
    error("property requires a 'set' function", 2)
  end

  return {
    get = args.get,
    set = args.set,
    [class_property_flag] = true,
  }
end

--- Check if an object's type is other or derived from other
--
-- @param a The instance to check
-- @param b The class type table to see if self is derived from
-- @usage
-- local class = require("class")
--
-- local A = class {}
-- local B = class {}
-- local C = class(A, B) {}
-- local D = class(C) {}
--
-- local inst = D()
-- print(inst:__instance_of(A)) -- true
-- print(class.instance_of(inst, A)) -- true
local function instance_of(a, b)
  return a:__instance_of(b)
end

--- Create a new class inherited from other classes
--
-- @tparam table extends An array of classes to extend
-- @tparam bool strict Whether access of undefined members should throw an error
--
-- @treturn function A function to call with a table of members
local function new_inherited_class(extends, strict)
  return function(members)
    -- Check that if any parents were strict, this is also strict
    if not strict then
      for _, v in pairs(extends) do
        if v.__strict then
          error("Tried to create a non-strict class with a parent class that is strict", 2)
        end
      end
    end

    -- Check for properties
    local properties = {}
    local properties_len = 0
    for k, v in pairs(members) do
      if type(v) == "table" and v[class_property_flag] then
        properties[k] = {get = v.get, set = v.set}
        properties_len = properties_len + 1
      end
    end

    local has_properties = properties_len > 0
    if not has_properties then
      -- Check if any parents have properties
      for _, v in pairs(extends) do
        if v.__has_properties then
          has_properties = true
          break
        end
      end
    end

    -- Remove properties from the class table as we rely on the __index and __newindex metamethods
    for k, _ in pairs(properties) do
      members[k] = nil
    end

    -- Inheritance locator is a function for __index, to locate a value for a given key
    local inheritance_locator
    if #extends == 1 then
      inheritance_locator = extends[1].__members
    else
      inheritance_locator = function(_, k)
        for _, i_v in pairs(extends) do
          local val = i_v.__members[k]
          if val then return val end
        end
      end
    end

    local property_inheritance_locator
    if #extends == 1 then
      property_inheritance_locator = extends[1].__properties
    else
      property_inheritance_locator = function(_, k)
        for _, i_v in pairs(extends) do
          local val = i_v.__properties[k]
          if val then return val end
        end
      end
    end

    -- Enable inheritance
    setmetatable(members, {__index = inheritance_locator})
    setmetatable(properties, {__index = property_inheritance_locator})

    -- Enable property getting
    local instance_index
    if not has_properties and not strict then
      instance_index = members
    elseif has_properties and not strict then
      -- Try to see if a property exists first, otherwise fall back to the members table
      instance_index = function(t, k)
        local prop = properties[k]
        if prop then return prop.get(t) end

        return members[k]
      end
    elseif has_properties and strict then
      -- Try to see if a property exists first, otherwise fall back to the members table
      instance_index = function(t, k)
        local prop = properties[k]
        if prop then return prop.get(t) end

        local member = members[k]
        if member == nil then error("Tried to read from undeclared member '" .. tostring(k) .. "'") end
        return member
      end
    elseif strict then
      instance_index = function(_, k)
        local member = members[k]
        if member == nil then error("Tried to read from undeclared member '" .. tostring(k) .. "'") end
        return member
      end
    end

    -- Handle property setting and strict classes
    local instance_newindex
    if has_properties and not strict then
      instance_newindex = function(t, k, v)
        local prop = properties[k]
        if prop then return prop.set(t, v) end

        rawset(t, k, v)
      end
    elseif has_properties and strict then
      instance_newindex = function(t, k, v)
        local prop = properties[k]
        if prop then return prop.set(t, v) end

        if t[k] == nil then error("Tried to assign to undeclared member '" .. k .. "'") end
        rawset(t, k, v)
      end
    elseif strict then
      instance_newindex = function(t, k, v)
        if t[k] == nil then error("Tried to assign to undeclared member '" .. k .. "'") end
        rawset(t, k, v)
      end
    end

    local obj_metatable = {
      __index = instance_index,
      __newindex = instance_newindex,
    }

    for _, v in pairs(extends) do
      if v.__members.__mt then
        for mt_k, mt_v in pairs(v.__members.__mt) do obj_metatable[mt_k] = mt_v end
      end
    end

    -- Also check for any metatable stuff
    for k, v in pairs(members) do
      if k == "__mt" then
        for mt_k, mt_v in pairs(v) do obj_metatable[mt_k] = mt_v end
      end
    end

    -- Create our class type object
    local type_value = {}

    type_value.__strict = strict

    -- Creates a new instance of the class
    type_value.__new = function(...)
      local args = {...}
      table.remove(args, 1)

      local t = {
        __type = type_value,
      }
      setmetatable(t, obj_metatable)
      members.__init(t, unpack(args))

      return t
    end

    type_value.__members = members
    type_value.__properties = properties
    type_value.__has_properties = has_properties
    type_value.__parents = extends

    setmetatable(type_value, {
      [class_flag] = true,
      __index = type_value.__members, -- For easy super calls
      __call = type_value.__new,
    })

    return type_value
  end
end

local function new_class(args, strict)
  -- Arg checking
  if #args == 0 then error("class takes at least one arg", 2) end
  for _, v in pairs(args) do
    if type(v) ~= "table" then error("class args must all be tables", 2) end
  end

  -- Check if we're creating a new base class or inheriting an existing one
  -- by seeing if args[1] has a metatable with class_flag = true
  local first_mt = getmetatable(args[1])
  if first_mt and first_mt[class_flag] then
    -- We're inheriting an existing class
    return new_inherited_class(args, strict)
  else
    -- We're creating a new class
    return new_inherited_class({BaseType}, strict)(args[1])
  end
end

--- Call to create a new strict class
--
-- <br>
-- This strict variant will error when trying to read from/write to undeclared members
--
-- @param ... This may be a single table containing your class definition, or one or more parent classes (in which
-- case this returns a function that you call with your class definition table)
--
-- @treturn table|function A new class type table derived from `BaseType` if called with no parent classes, otherwise
-- a function to create a new class type object
--
-- @raise
-- - "class takes at least one arg"
-- - "class args must all be tables"
--
-- @usage
-- -----------------------------------------------------------
-- -- New strict class inherited from the implicit BaseType --
-- -----------------------------------------------------------
--
-- local class = require("class")
--
-- local Vec2
-- Vec2 = class.strict {
--   x = class.NULL,
--   y = class.NULL,
--
--   __init = function(self, x, y)
--     self.x = x or 0
--     self.y = y or 0
--     -- self.other_member = 42 -- THIS WOULD ERROR as we never declared other_member above
--   end,
--
--   -- Set metatable members
--   __mt = {
--     __eq = function(self, other) return self.x == other.x and self.y == other.y end,
--     __add = function(self, other) return Vec2(self.x + other.x, self.y + other.y) end,
--     __sub = function(self, other) return Vec2(self.x - other.x, self.y - other.y) end,
--     __mul = function(self, other) return Vec2(self.x * other.x, self.y * other.y) end,
--     __div = function(self, other) return Vec2(self.x / other.x, self.y / other.y) end,
--     __len = function(self) return math.sqrt(self.x ^ 2 + self.y ^ 2) end,
--     __unm = function(self) return Vec2(-self.x, -self.y) end,
--     __tostring = function(self) return string.format("(%f, %f)", self.x, self.y) end,
--   },
-- }
--
-- @usage
-- ------------------------------------------------------
-- -- New strict class inherited from Sprite and Named --
-- ------------------------------------------------------
--
-- local class = require("class")
--
-- local Sprite = class.strict {...}
-- local Named = class.strict {...}
--
-- local NamedSprite
-- NamedSprite = class.strict(Sprite, Named) {
--   __init = function(self, position, texture, name)
--     Sprite.__init(self, position, texture)
--     Named.__init(self, name)
--   end,
-- }
local function strict(...)
  return new_class({...}, true)
end

--- @export
local class = {
  strict = strict,
  BaseType = BaseType,
  property = property,
  instance_of = instance_of,
  NULL = NULL,
}

setmetatable(class, {
  --- Call to create a new class
  --
  -- @param ... This may be a single table containing your class definition, or one or more parent classes (in which
  -- case this returns a function that you call with your class definition table)
  --
  -- @treturn table|function A new class type table derived from `BaseType` if called with no parent classes, otherwise
  -- a function to create a new class type object
  --
  -- @raise
  -- - "class takes at least one arg"
  -- - "class args must all be tables"
  -- - "Tried to create a non-strict class with a parent class that is strict"
  --
  -- @usage
  -- local class = require("class")
  --
  -- local Actor
  -- Actor = class {
  --   __init = function(self, name)
  --     self.name = name
  --   end,
  --
  --   enter_stage = function(self)
  --     print("*" .. self.name .. "\t\tenters the stage*")
  --   end,
  --
  --   leave_stage = function(self)
  --     print("*" .. self.name .. "\t\tleaves the stage*")
  --   end,
  --
  --   dance = function(self, adjective)
  --     print("*" .. self.name .. "\t\tdances with " .. adjective .. "*")
  --   end,
  --
  --   speak = function(self, msg)
  --     print(self.name .. ":\t\t" .. msg)
  --   end,
  -- }
  --
  -- -- Bea inherits from Actor
  -- local Bea
  -- Bea = class(Actor) {
  --   __init = function(self)
  --     Actor.__init(self, "Bea") -- Call super __init
  --   end,
  --
  --   leave_stage = function(self)
  --     -- Bea leaves the stage in style
  --     self:dance("style")
  --     Actor.leave_stage(self)
  --   end,
  -- }
  --
  -- local Cleaner
  -- Cleaner = class {
  --   clean_stage = function(self)
  --     print("The stage has been cleaned")
  --   end,
  -- }
  --
  -- -- Travis is both a cleaner and an actor
  -- -- Multiple inheritance!
  -- local Travis
  -- Travis = class(Actor, Cleaner) {
  --   __init = function(self)
  --     Actor.__init(self, "Travis")
  --   end,
  --
  --   speak = function(self, msg)
  --     print(self.name .. " (loud):\t" .. msg)
  --   end,
  -- }
  --
  -- -- Ok, let's act out a play
  -- local bea = Bea()
  -- local travis = Travis()
  -- local ferris = Actor("Ferris")
  --
  -- travis:clean_stage()
  -- bea:enter_stage()
  -- travis:enter_stage()
  -- travis:speak("I challenge thee to a dance-off!")
  -- bea:speak("Challenge accepted. Bring. It. On.")
  -- travis:dance("passion")
  -- ferris:enter_stage()
  -- travis:dance("fury")
  -- bea:dance("passion")
  -- bea:dance("elegance")
  -- bea:dance("frenzy")
  -- travis:speak("As you can see my dancing excellence clearly outmatches yours")
  -- bea:speak("Who said you get to be the judge?")
  -- travis:speak("Can't you see tha...")
  -- bea:speak("Hey - you there! What's your name?")
  -- ferris:speak("F...Ferris")
  -- bea:speak("Who do you think had the smoother moves?")
  -- ferris:speak("y.you")
  -- travis:speak("Wh...")
  -- travis:speak("Maam are you blind or something!? Couldn't you see my...")
  -- bea:speak("Right, I'm out of here")
  -- bea:leave_stage()
  -- travis:speak("Hhmph")
  -- travis:leave_stage()
  -- ferris:leave_stage()
  -- travis:clean_stage()
  --
  -- -- Output
  -- -- ------
  -- -- The stage has been cleaned
  -- -- *Bea            enters the stage*
  -- -- *Travis         enters the stage*
  -- -- Travis (loud):  I challenge thee to a dance-off!
  -- -- Bea:            Challenge accepted. Bring. It. On.
  -- -- *Travis         dances with passion*
  -- -- *Ferris         enters the stage*
  -- -- *Travis         dances with fury*
  -- -- *Bea            dances with passion*
  -- -- *Bea            dances with elegance*
  -- -- *Bea            dances with frenzy*
  -- -- Travis (loud):  As you can see my dancing excellence clearly outmatches yours
  -- -- Bea:            Who said you get to be the judge?
  -- -- Travis (loud):  Can't you see tha...
  -- -- Bea:            Hey - you there! What's your name?
  -- -- Ferris:         F...Ferris
  -- -- Bea:            Who do you think had the smoother moves?
  -- -- Ferris:         y.you
  -- -- Travis (loud):  Wh...
  -- -- Travis (loud):  Maam are you blind or something!? Couldn't you see my...
  -- -- Bea:            Right, I'm out of here
  -- -- *Bea            dances with style*
  -- -- *Bea            leaves the stage*
  -- -- Travis (loud):  Hhmph
  -- -- *Travis         leaves the stage*
  -- -- *Ferris         leaves the stage*
  -- -- The stage has been cleaned
  __call = function(...)
    local args = {...}
    table.remove(args, 1)
    return new_class(args, false)
  end,
})

return class
