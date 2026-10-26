--------------------------------------------------------------
--                      Readout Plugin                      --
--                         PLUG-0013                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Readout plugin provides an easy way to print a message to the screen in a semi-transparent pane that scrolls onto the screen, waits a few seconds, and then scrolls off of the screen. The pane is ideally drawn on top of everything else; it is therefore recommended to place this plugin near the bottom of the plugin chain.

                          Parameters
                          ----------
* fontSize   - Font Size of Readout Message                           (default: 40)
* ySpeed     - Speed of message's movement in 60ths of second         (default: 180)
* duration   - Time message remains on screen in 60ths of second      (default: 180)
* silent     - Whether to suppress debug messages                     (default: false)
* accessorFn - String representing a global function to access plugin (default: nil)

Printing out a message is only possible by triggering the Readout plugin's print() method.

This can currently only be done by obtaining a reference through the plugin via the accessorFn parameter.        

--]]

local GRAFX     = love.graphics
local COLOR     = require("game/constants/colors")

return {
    create = function(self, params)
        params = params or {}
        
        local FONT_SIZE   = params.fontSize or 40
        local Y_SPEED     = params.ySpeed   or 180
        local DURATION    = params.duration or 180

        local SILENT_MODE = params.silent

        local FONT        = GRAFX.newFont(FONT_SIZE)

        return {
            message  = nil,
    
            x  = 0,
            y  = GRAFX.getHeight(),
            w  = GRAFX.getWidth(),
            h  = 70,

            timer    = 0,
            velocity = 0,

            draw = function(self)
                if self.message ~= nil then
                    self:drawBox()
                    self:drawMessage()
                end
            end,

            drawBox = function(self)
                GRAFX.setColor(COLOR.TRANSLUCENT_BLACK)
                GRAFX.rectangle("fill", 0,  self.y - 10, self.w, self.h)

                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.rectangle("line", 0,  self.y - 10, self.w, self.h) 
            end,

            drawMessage = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setFont(FONT)

                GRAFX.printf(self.message, self.x, self.y, self.w, "center")
            end,

            update = function(self, dt)
                if     self.velocity ~= 0 then self:updateY(dt)
                elseif self.timer     > 0 then self:updateTimer(dt)
                else                           self:triggerMessageDeparture()           end
            end,

            updateY = function(self, dt)
                self.y = self.y + (self.velocity * dt)
                
                if     self.y < GRAFX.getHeight() - 60 then self:onMessageArrival()
                elseif self.y > GRAFX.getHeight()      then self:onMessageDeparture()   end
            end,

            onMessageArrival = function(self)
                self.y = GRAFX.getHeight() - 60
                self.velocity = 0
            end,

            onMessageDeparture = function(self)
                self.y = GRAFX.getHeight()
                self.velocity = 0
                self:clearMessage()
            end,

            updateTimer = function(self, dt)
                self.timer = self.timer - (60 * dt)
            end,

            clearMessage = function(self)
                self.message = nil
            end,

            print = function(self, message)
                if not SILENT_MODE then
                    print("Printing to Readout: ", message)
                end

                self:triggerMessageArrival(message)
            end,

            triggerMessageArrival = function(self, message)
                self.message = message
                self.velocity = -Y_SPEED
                self.timer    = DURATION
            end,

            triggerMessageDeparture = function(self)
                self.velocity = Y_SPEED
            end,

        }
        
    end,

}
