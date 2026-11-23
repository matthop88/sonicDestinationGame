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
                self.dialog = require("plugins/modules/fileSaver/dialog"):create {
                    x       = params.x,
                    y       = params.y,
                    w       = params.w,
                    h       = params.h,
                    caption = "Save Edited File",
                    okText  = "Save",
                    visible = true,
                }

        		return self
        	end,

            draw = function(self)
                if self.visible then
                    self:drawDialog()
                    self:drawTextfield()
                end
            end,

            drawDialog = function(self)         
                self.dialog:draw()
            end,

            drawTextfield = function(self)
                GRAFX.setColor(COLORS.MEDIUM_GREY)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save As:", self.x + 12, self.y + 48, 1000, "left")
                self.textField:draw()
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
