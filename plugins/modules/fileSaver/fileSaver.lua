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

                self.FONT = GRAFX.newFont(20)

        		return self
        	end,

            draw = function(self)
                self:drawPanel()
                self:drawCaption()
                self:drawTextfield()
            end,

            drawPanel = function(self)         
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h)
                GRAFX.setColor(COLORS.PURE_WHITE)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h)
            end,

            drawCaption = function(self)
                GRAFX.setColor(COLORS.BURNT_ORANGE)
                GRAFX.rectangle("fill", self.x, self.y, self.w, 30)
                GRAFX.setColor(COLORS.JET_BLACK)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save Edited File", self.x, self.y + 3, self.w, "center")
                GRAFX.rectangle("line", self.x, self.y, self.w, 30)
            end,

            drawTextfield = function(self)
                GRAFX.setColor(COLORS.MEDIUM_GREY)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save As:", self.x + 12, self.y + 48, 1000, "left")
                GRAFX.setColor(COLORS.VERY_DARK_GREY)
                GRAFX.rectangle("fill", self.x + 106, self.y + 45, self.w - 120, 30)
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("sonic1Transparent.png", self.x + 118, self.y + 48, 1000, "left")
            end,
        	
        }):init(params)

    end,
}
