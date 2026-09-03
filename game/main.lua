--------------------------------------------------------------
--                      Local Functions                     --
--------------------------------------------------------------

local loadWindow = function(path)
	local window = require("config/window")
    
    love.window.setTitle(window.title)
	love.window.setMode(window.width, window.height)
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.load(args)
    loadWindow()
	
	require("application")
end






