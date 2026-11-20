--------------------------------------------------------------
--                      Color Inspector                     --
--                        Version 0.11                      --
--                                                          --
--                 Functional Specifications                --
--                         TOOL-0035                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
An image of choice is drawn to the screen.
Clicking on any pixel of the image prints an RGB description of the color 
both to the screen and to the text console.

Input file is no longer required from command line.
Instead, a file dialog can be used to open up an image file.
The "l" key can also be used to dynamically bring up the dialog.

                           Features
                           --------
- [X] Command line no longer required
- [X] "l" key used to dynamically bring up dialog
- [X] File dialog shows up if image not specified

--]]

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

------------------------- INSPECTION -------------------------

local COLOR_INSPECTOR = {
    printRGBToConsole = function(self, r, g, b)
        print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
    end,

    printRGBToReadout = function(self, r, g, b)
        local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
        getReadout():print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
    end,

    onColorSelected = function(self, r, g, b)
        self:printRGBToConsole(r, g, b)
        self:printRGBToReadout(r, g, b)
    end,

    onFileSelected = function(self, text)
        local filePath  = "game/resources/images/spriteSheets/sonic1"
        local imagePath = filePath .. "/" .. text .. ".png"
        local imageView = getImageView()

        imageView.imagePath = imagePath
        imageView:reload()
        imageView.disabled = false
        
        getFileChooser():hide()
    end,  

}

function love.keypressed(key)
    if key == "l" then
        getFileChooser():show()
    end
end


--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

local FILE_PATH      = "game/resources/images/spriteSheets/sonic1"
local IMAGE_PATH     = FILE_PATH .. "/" .. (__PARAMS["imageFile"] or "") .. ".png"
local BAD_IMAGE_PATH = "tools/colorInspector/resources/fileNotFound.png"

require("plugins/engine")
    :add { "showValidFilenames", { filePath  = FILE_PATH, extension = ".png", 
                                   fileType  = "Image",   
                                   condition = function() return __PARAMS["imageFile"] == "_" end, } }
    --------------------------------------------------------------------------------------------------   
    :add { "imageView",     { imagePath  = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, accessorFn = "getImageView", disabled = __PARAMS["imageFile"] == nil, } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 48, ySpeed = 600, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    :add { "colorSelector", { imageView  = getImageView(), onColorSelected = COLOR_INSPECTOR, } }
    :add { "fileChooser",   { 
        x = 400,
        y = 100,
        w = 400,
        h = 400, 
        filePath       = FILE_PATH,
        onFileSelected = COLOR_INSPECTOR,
        accessorFn     = "getFileChooser", 
        visible        = __PARAMS["imageFile"] == nil,
    } }







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
