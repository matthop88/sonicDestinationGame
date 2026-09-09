return {
    create = function(self, params)
        return {
            SCROLL_SPEED = params.SCROLL_SPEED,
            imageView    = params.imageView,
            DOUBLE_TAP   = params.DOUBLE_TAP,
            ZOOMING      = params.ZOOMING,
    
            xSpeed       = 0,
            ySpeed       = 0,
            
            scaleDelta = 0,

            scrollUp           = function(self) self.ySpeed =  self.SCROLL_SPEED:get() end,
            scrollDown         = function(self) self.ySpeed = -self.SCROLL_SPEED:get() end,
            scrollLeft         = function(self) self.xSpeed =  self.SCROLL_SPEED:get() end,
            scrollRight        = function(self) self.xSpeed = -self.SCROLL_SPEED:get() end,

            stopScrollingUp    = function(self) self.ySpeed = math.min(0, self.xSpeed) end,
            stopScrollingDown  = function(self) self.ySpeed = math.max(0, self.ySpeed) end,
            stopScrollingLeft  = function(self) self.xSpeed = math.min(0, self.xSpeed) end,
            stopScrollingRight = function(self) self.xSpeed = math.max(0, self.xSpeed) end,

            update             = function(self, dt)
                self.imageView:move(self.xSpeed * dt, self.ySpeed * dt)
                if self.xSpeed == 0 and self.ySpeed == 0 and not self.DOUBLE_TAP:withinThreshold() and self.ZOOMING.scaleDelta <= 0 then
                    self.imageView:keepInBounds()
                end
            end,

        }

    end,
}
