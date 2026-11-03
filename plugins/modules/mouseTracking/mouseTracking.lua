--------------------------------------------------------------
--                      Mouse Tracking                      --
--                        Version 0.1                       --
--                         PLUG-0020                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
Given two callbacks (one to get coordinates and one to set coordinates),
as well as a key to toggle mouse tracking,
this plugin repeatedly calls the set coordinates function to 
cause the desired object to track the mouse

                          Parameters
                          ----------
* toggleKey - the key to toggle mouse tracking. Defaults to nil.
* getXYFn   - a function to get the X, Y coordinates of the object
* setXYFn   - a function to set the X, Y coordinates of the object

--]]

return {
    create = function(self, params)
        local origX, origY

        if params.getXYFn then origX, origY = params.getXYFn() end
        
        return {
            toggleKey   = params.toggleKey,
            setXY       = params.setXYFn,

            followMouse = false,
            origX       = origX,
            origY       = origY,

            update           = function(self, dt)
                if self.followMouse and self.setXY then
                    self.setXY(love.mouse.getPosition())
                end
            end,

            handleKeypressed = function(self, key)
                if key == self.toggleKey then
                    self.followMouse = not self.followMouse
                    love.mouse.setVisible(not self.followMouse)
            
                    if not self.followMouse and self.origX then
                        self.setXY(self.origX, self.origY)
                    end
                end
            end,
        }
    end,
    
}
