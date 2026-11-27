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
            onItemSelected = function(self, item)
                print("Item Selected: " .. item)
            end,

        	init = function(self, params)
        		self.x       = params.x       or 300
                self.y       = params.y       or 100
                self.w       = params.w       or 200
                self.h       = params.h       or 400
                self.visible = params.visible
                self.path    = params.filePath

                self.FONT    = GRAFX.newFont(20)
                self.dialog = require("lib/gui/components/dialogs/dialog"):create {
                    x       = self.x,
                    y       = self.y,
                    w       = self.w,
                    h       = self.h,
                    caption = "Save Edited File",
                    okText  = "Save",
                    visible = params.visible,
                    components = {
                        textField = require("lib/gui/components/text/textField"):create {
                            text = "sonic1Transparent",
                            ext  = "png",
                            x    = self.x + 106,
                            y    = self.y +  45,
                            w    = self.w - 120,
                        },
                        listPanel = require("lib/gui/components/lists/listPanel"):create {
                            x = self.x +   5,
                            y = self.y +  90,
                            w = self.w -  10,
                            h = self.h - 150,
                            list = DIRECTORY_UTIL:getFilesInDirectory(self.path, ".png"),
                            onSelected = function(item) self:onItemSelected(item) end,
                        },
                    }
                }

                self.textField = self.dialog:getComponent("textField")

        		return self
        	end,

            draw = function(self)
                self.dialog:draw()
                if self.dialog.visible then
                    self:drawTextfieldLabel()
                end
            end,

            drawTextfieldLabel = function(self)
                GRAFX.setColor(COLORS.MEDIUM_GREY)
                GRAFX.setFont(self.FONT)
                GRAFX.printf("Save As:", self.x + 12, self.y + 48, 1000, "left")
            end,

            handleKeypressed = function(self, key)
                return self.dialog:handleKeypressed(key)
            end,

            handleMousepressed = function(self, mx, my)
                return self.dialog:handleMousepressed(mx, my)
            end,

            handleMousereleased = function(self, mx, my)
                return self.dialog:handleMousereleased(mx, my)
            end,

            update = function(self, dt)
                self.dialog:update(dt)
            end,

            show = function(self)
                self.dialog:show()
            end,

            hide = function(self)
                self.dialog:hide()
            end,

            setText = function(self, text)
                self.textField:setText(text)
            end,
        	
        }):init(params)

    end,
}
