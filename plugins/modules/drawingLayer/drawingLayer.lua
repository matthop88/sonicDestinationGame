--------------------------------------------------------------
--                     Drawing Layer Plugin                 --
--                          PLUG-????                       --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Drawing Layer plugin allows you to assign a drawing function to carry out
drawing operations at a specific point in the plugin chain.

Without this plugin, standard love.draw() operations execute prior to draw
operations of all plugins, resulting in all love.draw() operations occurring in
the background.

                          Parameters
                          ----------
            * drawingFn - the actual function that will do the drawing.
                          drawingFn itself is expected to have no parameters.
                          
--]]

return {
    create = function(self, params)
        return {
            drawingFn = params.drawingFn,

            draw      = function(self)
                if self.drawingFn then
                    self.drawingFn()
                end
            end,

        }
    end,
    
}
