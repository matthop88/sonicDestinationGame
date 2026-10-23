return {
    create = function(self, params)
        return {
            zoomSpeed = params.zoomSpeed or 2,
            imageView = params.imageView,
    
            scaleDelta = 0,

            zoomIn  = function(self) 
                self.scaleDelta = self.zoomSpeed              
            end,

            zoomOut = function(self) 
                self.scaleDelta = -self.zoomSpeed
            end,

            stopZoomingIn = function(self) 
                self.scaleDelta = math.min(0, self.scaleDelta) 
            end,

            stopZoomingOut = function(self) 
                self.scaleDelta = math.max(0, self.scaleDelta) 
            end,

            update = function(self, dt)
                local mx, my = love.mouse.getPosition()

                self.imageView:scaleGeometrically(self.scaleDelta * dt, mx, my)
            end,

            handleKeypressed = function(self, key)
                if     key == "z" then self:zoomIn()
                elseif key == "a" then self:zoomOut()
                end
            end,

            handleKeyreleased = function(self, key)
                if     key == "z" then self:stopZoomingIn()
                elseif key == "a" then self:stopZoomingOut()
                end
            end,

        }

    end,
}
