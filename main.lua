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

	    scribbler = {
	    	PATH     = "tools/scribbler/",
	    	APP_NAME = "scribblerApp",
	    },
	},

	getPathAndAppName = function(self, keyword)
		return self.appData[keyword].PATH, self.appData[keyword].APP_NAME
	end,
}

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

local requireSafely = function(filename)
	local success, module = pcall(require, filename)

	if success then 
		return module 
	end
end

local loadWindow = function(path)
	local window = requireSafely(path .. "config/window")

	if window then
	    love.window.setTitle(window.title)
	    love.window.setMode(window.width, window.height)
	end
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.load(args)
    local path, appName = APPLICATIONS:getPathAndAppName(args[1] or "game")
    
    requireRelative = function(p) return require(path .. p) end

    loadWindow(path)

	local COMMAND_LINE_TOOLS = require("lib/cmd/commandLineTools"):create(path .. "config/")
	
	if COMMAND_LINE_TOOLS:validateParams(args) and not COMMAND_LINE_TOOLS:respondToHelp(args) then
		__PARAMS = COMMAND_LINE_TOOLS:getParams(args)

		require(path .. appName)
    end
end



