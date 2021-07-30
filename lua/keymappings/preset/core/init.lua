-- Contains core plugins specific keymappings
local compe = require "keymappings.preset.core.compe"
local telescope = require "keymappings.preset.core.telescope"
local bufferline = require "keymappings.preset.core.bufferline"

local keys = {}
keys.compe = compe
keys.telescope = telescope
keys.bufferline = bufferline

return keys
