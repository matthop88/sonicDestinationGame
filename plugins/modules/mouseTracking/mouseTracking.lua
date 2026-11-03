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


