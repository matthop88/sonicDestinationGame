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
                self.textField = require("plugins/modules/fileSaver/textField"):create {
                    text = "sonic1Transparent.png",
                    x    = self.x + 106,
                    y    = self.y +  45,
                    w    = self.w - 120,
                }
                self.saveButton = require("plugins/modules/fileSaver/button"):create {
                    text = "Save",
                    x    = self.x + self.w - 120,
                    y    = self.y + self.h -  50,
                    w    = 100,
                }
                self.visible = params.visible

        		return self
        	end,

            draw = function(self)
                if self.visible then
                    self:drawPanel()
                    self:drawCaption()
                    self:drawTextfield()
                    self:drawButtons()
                end
            end,

            drawPanel = function(self)         
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h, 20, 20)
            end,

            drawCaption = function(self)
                GRAFX.setColor(COLORS.BURNT_ORANGE)
                GRAFX.rectangle("fill", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.JET_BLACK)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save Edited File", self.x, self.y + 3, self.w, "center")
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.rectangle("line", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x + 1, self.y + 30, self.w - 2, 16)
            end,

            drawTextfield = function(self)
                GRAFX.setColor(COLORS.MEDIUM_GREY)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save As:", self.x + 12, self.y + 48, 1000, "left")
                self.textField:draw()
            end,

            drawButtons = function(self)
                self.saveButton:draw()
            end,

            show = function(self)
                self.visible = true
            end,

            hide = function(self)
                self.visible = false
            end,

            setText = function(self, text)
                self.textField.text = text
            end,

            handleKeypressed = function(self, key)
                if self.visible then
                    if key == "escape" then
                        self.visible = false
                    end
                    return true
                end
            end,
        	
        }):init(params)

    end,
}
