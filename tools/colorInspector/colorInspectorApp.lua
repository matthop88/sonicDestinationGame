--------------------------------------------------------------
--                      Color Inspector                     --
--                        Version 0.1                       --
--                                                          --
--                 Functional Specifications                --
--                         TOOL-0002                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
An image of choice is drawn to the screen.
Clicking on any pixel of the image prints an RGB description of the color 
both to the screen and to the text console.

                           Features
                           --------
- [X] Image can be scrolled using the up, down, left and right arrow keys.
- [X] Double-tapping speeds up image scrolling.
- [X] Image can be zoomed in using the 'z' key and zoomed out using the 'a' key
- [X] Clicking on any pixel of the image prints an RGB description of the color 
      both to the screen and to the text console.
- [X] Image can be chosen from the command-line.
- [X] List of possible images can be viewed with "-i" underscore.
- [X] Stand-in image is loaded when image cannot be found.

--]]

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

------------------------- INSPECTION -------------------------

local printRGBToConsole = function(r, g, b)
    print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
end

local printRGBToReadout = function(r, g, b)
    local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
    getReadout():print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

local onColorSelected = function(r, g, b)
    printRGBToConsole(r, g, b)
    printRGBToReadout(r, g, b)
end

--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

local FILE_PATH      = "game/resources/images/spriteSheets/sonic1"
local IMAGE_PATH     = FILE_PATH .. "/" .. __PARAMS["imageFile"] .. ".png"
local BAD_IMAGE_PATH = "tools/colorInspector/resources/fileNotFound.png"

require("plugins/engine")
    :add { "showValidFilenames", { filePath  = FILE_PATH, extension = ".png", 
                                   fileType  = "Image",   
                                   condition = function() return __PARAMS["imageFile"] == "_" end, } }
    --------------------------------------------------------------------------------------------------   
    :add { "imageView",     { imagePath  = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, accessorFn = "getImageView", } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 48, ySpeed = 600, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    :add { "colorSelector", { imageView  = getImageView(), onColorSelected = onColorSelected, } }








--[[

          *************     ******************    ******************           *****           
      *****************   ********************  ********************         **********      
     ******              ******                *****                        ************            
    ****   ************  ***** *************** **** ****************       *****   ******           
   ****  **************  ***** *************** **** ****************      *****  ** *****           
   **** ****             ***** ***             **** ****                  ***** ***  *****          
    ***  **********      ***** *************   **** **** ***********     ***** ***** ******         
     ****    ********    ***** *************   **** **** ***********    ****** ****** *****         
      *******     ****   ***** *************   **** **** ****** ****    ***** ******* ******        
        **********  ***  ***** *************   **** **** ****** ****   *****  *** **** *****        
               **** **** ***** ***             **** ****   **** ****  ****** ****  **** *****       
    **************  ***  ***** *************** **** *********** ****  ***** *********** ******      
    ************   ****  ***** *************** **** *********** **** ****** ************ *****      
                ******   ******                *****            **** ***** ***            *****     
    ****************      ********************  ************************* ***  *****************    
    *************           ******************    *********************** ***  *****************   

--]]
