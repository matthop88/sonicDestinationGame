--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local APPLICATIONS = {
    appData = {
		game = {
	        PATH     = "game/",
	        APP_NAME = "main",
	    },
	
	    inspector = {
	        PATH     = "tools/colorInspector/",
	        APP_NAME = "colorInspectorApp",
	    },
	},

	getPathAndAppName = function(self, keyword)
		return self.appData[keyword].PATH, self.appData[keyword].APP_NAME
	end,
}

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.load(args)
    local PATH, APP_NAME = APPLICATIONS:getPathAndAppName(args[1])
    
	local WINDOW         = require(PATH .. "config/window")

    love.window.setTitle(WINDOW.TITLE)
    love.window.setMode(WINDOW.WIDTH, WINDOW.HEIGHT)

    require(PATH .. APP_NAME)
end
