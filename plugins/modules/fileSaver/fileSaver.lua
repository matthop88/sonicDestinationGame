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

return {
    create = function(self, params)
        
        return ({

        	init = function(self, params)
        		-- Operate on params

        		return self
        	end,

        	--draw                = function(self)         end,
        	--update              = function(self, dt)     end,
        	--handleKeypressed    = function(self, key)    end,
        	--handleKeyreleased   = function(self, key)    end,
        	--handleMousepressed  = function(self, mx, my) end,
        	--handleMousereleased = function(self, mx, my) end,

        }):init(params)

    end,
}
