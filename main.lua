local PATH, APP_NAME = "game/",                 "main"
--local PATH, APP_NAME = "tools/colorInspector/", "colorInspectorApp"

local WINDOW = require(PATH .. "config/window")

love.window.setTitle(WINDOW.TITLE)
love.window.setMode(WINDOW.WIDTH, WINDOW.HEIGHT)

require(PATH .. APP_NAME)
