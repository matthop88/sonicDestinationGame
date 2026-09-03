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
    local PATH, APP_NAME = APPLICATIONS:getPathAndAppName(args[1] or "game")
    
	loadWindow(PATH)

    require(PATH .. APP_NAME)
end

function loadWindow(path)
	local WINDOW = requireSafely(path .. "config/window")

	if WINDOW then
	    love.window.setTitle(WINDOW.TITLE)
	    love.window.setMode(WINDOW.WIDTH, WINDOW.HEIGHT)
	end
end

function requireSafely(filename)
	local success, module = pcall(require, filename)

	if success then 
		return module 
	end
end

