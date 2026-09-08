--------------------------------------------------------------
--                      Global Variables                    --
--------------------------------------------------------------

PARENT_PATH = "game/"

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local APPLICATIONS = {
    appData = {
    	------------------------ GAME ------------------------
		game = {
	        PATH     = "game/",
	        APP_NAME = "application",
	    },

	    ----------------------- TESTS ------------------------
	    test = {
	    	PATH     = "test/",
	    	APP_NAME = "framework",
	    },
	
		----------------------- TOOLS ------------------------
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
    local path, appName = APPLICATIONS:getPathAndAppName(args[1] or "game")
    
	loadWindow(path)

	local COMMAND_LINE_TOOLS = require("lib/cmd/commandLineTools"):create(path .. "config/")
	COMMAND_LINE_TOOLS:listParams(args)

    require(path .. appName)
end

function loadWindow(path)
	local window = requireSafely(path .. "config/window")

	if window then
	    love.window.setTitle(window.title)
	    love.window.setMode(window.width, window.height)
	end
end

function requireSafely(filename)
	local success, module = pcall(require, filename)

	if success then 
		return module 
	end
end

