local APPLICATIONS = {
    game = {
        PATH     = "game/",
        APP_NAME = "main",
    },

    inspector = {
        PATH     = "tools/colorInspector/",
        APP_NAME = "colorInspectorApp",
    },
}

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.load(args)
    local MY_APP   = args[1]
	local PATH     = APPLICATIONS[MY_APP].PATH
    local APP_NAME = APPLICATIONS[MY_APP].APP_NAME

    local WINDOW   = require(PATH .. "config/window")

    love.window.setTitle(WINDOW.TITLE)
    love.window.setMode(WINDOW.WIDTH, WINDOW.HEIGHT)

    require(PATH .. APP_NAME)
end
