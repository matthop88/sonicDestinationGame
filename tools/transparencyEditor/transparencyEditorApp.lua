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
local BAD_IMAGE_PATH = "tools/transparencyEditor/resources/fileNotFound.png"

require("plugins/engine")
    :add { "showValidFilenames", { filePath  = FILE_PATH, extension = ".png", 
                                   fileType  = "Image",   
                                   condition = function() return __PARAMS["inFile"] == "_" end, } }
    --------------------------------------------------------------------------------------------------   
    :add { "custom",        { object     = requireRelative("lib/transparencyEngine"), accessorFn = "getTransparencyEngine", } }
    :add { "imageView",     { imagePath  = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, pixelated = true, accessorFn = "getImageView", } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 36, ySpeed = 600, height = 100, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    :add { "colorSelector", { imageView  = getImageView(), onColorSelected = getTransparencyEngine(), } }
    :add { "custom",        { object     = requireRelative("lib/fileChooser/fileChooserPanel"), } }

local ASCII_ART = [[
                                                                                                                    
                                         $$XXXxxxxxxxxXXX$$                                                         
                                    $XXxxx+++++xxXXXXXX$$&&                                                         
                                $$XX+x+x++x+xxXXXXX$$$$$&                                                           
                              $X+++x++++x++xXXXX$++XXX$                                                             
                           $Xx++x+++x+x++xXXX$xxXXXXXXX$                                                            
                         $X+++x++x+++++x+XXX+XXX++;+XXX$                                                            
                $$$$$$$$X+x++++x++x++x++XXxxXX++;::;XXX$XX$$$$$                                                     
               $X++XXXX+x++x+x+;+;;+;++x+xXX+++::::;XX$XXXXXXXXX$$                                                  
                $x++XXx++x++++;;+;;+;;++++++xxXX++:;XX$$$XXXXXXXXXXX$                                               
                $X++$x++++x++;+;;+;++xXXXXx++++xXXXXXX$$$$$$$$$$$$$$XX$  +;;.:;;++                                  
                $Xx$X++x+++x+;;+;;++XXXXxxXXx++++XXXXX$$$$$$$$$$$$$$$$$x:      :;;X                                 
                 $X+++x++x++;+;;+++XXX;;;;;;xx+x+xXXXXXX$$$$$$$$$$$$$$$;       .;;+X                   ++++++++     
                $x++x+++x+++;;+;++xX;;.      ;x+++XXXXXX$$$$$$$$$$$$$$+         ;;+x               ++;;       .;;+  
                $x+X;X+x+++;+;;+++XX;.;X+:   .x+x+XXXXXX$$$$$$$$$$$&&x.         ;;+x           +;;.            .;;X 
                $X+X;:x++++;+;;+xXx;. $&&$.   +x+XXXXXXXX$$$$$&&&   +;;         ;;+X        +;:.                ;;; 
                 $XX: :Xx++x++++XX;;  +&&&+   +XXXXXXXXXX$$$&&     +; ;:        ;;+X   +++;;                   ;;;+X
                  $xx   XXx+++xX+;:    X&&&;  +XXXXXXXXXX$$$      +:  ;;       .;;X++++;                      ;;;++X
                   $X;  :&&XXXX;:      .&&&X .XXXXXXXXXX$$$$$$$$ +;:  ;;.      ;;+++++;:                   ;;;;;;++X
                    $X:  +&&X.          ;$&+ +xxXXXXXXXX$$$$$$$$$X;  .;;X;  ::;;+X+++;;:     :;:::::::;;;;;;;;;;++X 
                     $+   +&&;              . ....XXXXX$$$$$$$$$$X;  ;;;++X++++XXx+++;;;;..;;;;;;;;;;;;;;;;;;++++X  
                       $xXx...             ::;;:::+XXX$$$$$$$$$$$X;  ;;;++++++XXX++++++;;;;;;;;;+++++++++++++++X    
                      &&&Xx;  &&::::::::::::$&X+::+X&$$$$$$$$$X;  +:;;;;;++++XXXXx+++++x++++++++++XXXXXXXX          
                       &&&&&&&&&+::::::::+&&$&x::+X&$$$$$$$$xX.  .+;;;;;+++X;..:;;Xx+XX++++xX                       
                          X++++++:::::$&&$X$$;:;X&$$$$XX+;::X;  :;+;;;;+xXx;     .;;xX++++++++X                     
                   XX+;;xX X$x++++++;;::::;;+x$$$$x+;:::::;x;;;;;;+++++++++;.       ;;++Xx+++++X                    
                 X++;;;;;;;;+ $$$$X++++++$$$+$X$$+++++++++++;;;;+X;;;;;++X++;         ;;;++++++X                    
                  $X$;;++;;&+$$$+:;+++++:::::+XX$$$$$$$$$$x++;;;X++++++X;;;X+;;        ;;;+++++X                    
                  X+++xXXXXXX $$;:::::::::::++XXX$$$$$$$$$  X+++X+++++X.   :X++;;:     ;;;;++++X                    
                   XX          $+::::::::::;+XXXX$$$$$$$$$   XXXX++++X;:     ;+++;;;;;;;;;+++++X                    
                                X+;::::::+++XXXX$$$$$$$$$$$     XXX+++X;;     ;;Xx+++++;+++++x                      
                                $X++++++++XXXXXX&&&&$$$$$$$      X;;;;+X+;;;;;;;;;++++XXXXX                         
                             $XxXX&$XXXXXXXXXX$&&    &&$$$$      X+;;;;;+X+;;;;;;;;++++x                            
                          XX+xx$$&&&&&&&&&$XX&&&$&     &$$       X++;;;;;;xx+++;;++++++X                            
                 X:  xXXX+xXX&           &$X$&  $$&               X++++;;;;;+X+++++++X                              
                X. &&$++xX$              &XX&    &$&                X+++++++++X                                     
              x : .&$XX$$&+         XXXX$X&&       &                  XX+++++X                                      
            $$$ ::   :;;::;&       &;&&$$&$                              XXX                                        
          $$$X$; :;;..:;++$      &&;;;$&&$X                                                                         
        +;:  XX$$;;;;XXX&&       &$&;X+;+XX                                                                         
      $$XXXX:  XX$$$&&&$&       &$$$$$&&&                                                                           
    $$XXXXXXX.  X$$$$&&         &$$$$$$$&                                                                           
   $$XXXXXXXX$:;+$$&&           &X+;;;++$                                                                           
 $$XXXXXXXX$$$+X$&              &+$XXX$$X                                                                           
$$$XXXX$$$$$$&                   &$XXXX$$                                                                           
 $$$$$$&&&&                      &$XXXXX$                                                                           
                                  &$XXX$$                                                                           
                                  &$XXX$                                                                            
                                    $$$                                                                             
]]
