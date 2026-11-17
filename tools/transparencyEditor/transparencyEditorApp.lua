--------------------------------------------------------------
--                    Transparency Editor                   --
--                        Version 0.1                       --
--                                                          --
--                 Functional Specifications                --
--                         TOOL-0024                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
An image of choice is drawn to the screen.
Clicking on any pixel of the image gives the user the option of making
the color of that pixel transparent throughout the entire image.

The image can be saved in its new transparent format,
or reverted to its previous state.

                           Features
                           --------
- [X] Skeleton of new tool created
- [X] Image of choice drawn to screen, with scrolling, zooming, etc.
- [X] Clicking on image pixel gives option of transparency
- [X] Transparency functionality implemented for any specific color
- [X] Revert functionality implemented
- [X] Save functionality implemented, with customizable save filename
- [X] Overwrite protection added
- [ ] Destination directory selectable for save file

--]]


--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

local FILE_PATH      = "game/resources/images/spriteSheets/sonic1"
local IMAGE_PATH     = FILE_PATH .. "/" .. __PARAMS["inFile"] .. ".png"

require("plugins/engine")
    :add { "showValidFilenames", { filePath  = FILE_PATH, extension = ".png", 
                                   fileType  = "Image",   
                                   condition = function() return __PARAMS["inFile"] == "_" end, } }
    --------------------------------------------------------------------------------------------------   
    :add { "custom",        { object     = requireRelative("lib/transparencyEngine") } }
    :add { "imageView",     { imagePath  = IMAGE_PATH, pixelated = true, accessorFn = "getImageView", } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 36, ySpeed = 600, height = 100, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    :add { "colorSelector", { imageView  = getImageView(), onColorSelected = requireRelative("lib/transparencyEngine"), } }


--[[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀(ASCII ART GOES HERE)
--]]
