--------------------------------------------------------------
--                    Drawing Layer Plugin                  --
--                         PLUG-0016                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Drawing Layer plugin provides an easy way to draw on top of other plugins (or underneath them). Simply provide a drawing function to this plugin, and position the plugin appropriately in the plugin chain (below the plugins that you wish to draw on top of).

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
