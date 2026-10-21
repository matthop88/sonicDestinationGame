--------------------------------------------------------------
--                 Functional Specifications                --
--                         TOOL-0006                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
A Sprite Sheet is selected and drawn to the screen.
It can be scrolled and zoomed in the same fashion as the Color Inspector.
Initially, the borders of all sprite frames are automatically detected.
Thereafter, any time the mouse enters a sprite frame and the button is clicked, the attributes of the sprite frame (x, y, width, height) are displayed to the screen.

                           Features
                           --------
- [ ] Image can be scrolled using the up, down, left and right arrow keys.
- [ ] Double-tapping speeds up image scrolling.
- [ ] Image can be zoomed in using the 'z' key and zoomed out using the 'a' key
- [ ] Initially, image is scanned and all subimage boundaries are found.
- [ ] When mouse hovers over a subimage, its border lights up
- [ ] When mouse button is clicked, attributes of the subimage (x, y, width, height) are displayed on the screen.
- [ ] Image can be chosen from the command-line.
- [ ] List of possible images can be viewed with "-i" underscore.
- [ ] Stand-in image is loaded when image cannot be found.

--]]

