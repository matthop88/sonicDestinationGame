local DURATION = 180
local GRAFX    = love.graphics
local FONT     = GRAFX.newFont(40)
local COLOR    = require("game/constants/colors")
local Y_SPEED  = 180

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
        print("Printing to Readout: ", message)
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
