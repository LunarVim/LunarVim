local reload = require("c.reload")
reload.unload_user_modules()

local log = require("c.log")
log.init()

local layer = require("c.layer")
local keybind = require("c.keybind")
local autocmd = require("c.autocmd")

autocmd.init()

layer.add_layer("l.settings")
layer.add_layer("l.mappings")
layer.add_layer("l.functions")
layer.add_layer("l.theme")
layer.add_layer("l.goyo")
layer.add_layer("l.floaterm")
layer.add_layer("l.which-key")

layer.finish_layer_registration()

