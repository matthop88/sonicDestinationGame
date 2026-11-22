--------------------------------------------------------------
--                     File Saver Plugin                    --
--                        Version 0.1                       --
--                         PLUG-0036                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The File Chooser Plugin displays a dialog on the screen
where a filename can be typed in and saved to a specific place
on disk.
When the file is selected, a callback is called to actually
do the saving and the dialog goes away.

                          Parameters
                          ----------
* x              - x coordinate of dialog box (default: 300)
* y              - y coordinate of dialog box (default: 100)
* w              - width  of dialog box       (default: 200)
* h              - height of dialog box       (default: 400)
* filePath       - path of directory where files will be saved
* onFileSelected - object to call back, with method onFileSelected()
* visible        - whether dialog box is initially visible. Defaults to false.

--]]

local DIRECTORY_UTIL = require("lib/util/directoryUtil")

local GRAFX          = love.graphics
local MOUSE          = love.mouse

local COLORS         = require("game/constants/colors")

return {
    create = function(self, params)
        
        return ({

        	init = function(self, params)
        		self.x = params.x or 300
                self.y = params.y or 100
                self.w = params.w or 200
                self.h = params.h or 400

        		return self
        	end,

        	draw = function(self)         
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h)
                GRAFX.setColor(COLORS.PURE_WHITE)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h)
            end,
        	
        }):init(params)

    end,
}
