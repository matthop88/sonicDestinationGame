local PATH = "tools/colorInspector/"

local WINDOW = require(PATH .. "config/window")

love.window.setTitle(WINDOW.TITLE)
love.window.setMode(WINDOW.WIDTH, WINDOW.HEIGHT)

require(PATH .. "colorInspectorApp")
