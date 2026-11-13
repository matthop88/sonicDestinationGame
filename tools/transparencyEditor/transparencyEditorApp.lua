--------------------------------------------------------------
--              Transparency Editor           --
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
- [ ] Skeleton of new tool created
- [ ] Image of choice drawn to screen, with scrolling, zooming, etc.
- [ ] Clicking on image pixel gives option of transparency
- [ ] Transparency functionality implemented for any specific color
- [ ] Revert functionality implemented
- [ ] Save functionality implemented, with customizable save filename
- [ ] Overwrite protection added
- [ ] Destination directory selectable for save file

--]]


--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

require("plugins/engine")
    --:add { "plugin1",        { foo = "foo", bar = "bar",  } }
    --:add { "plugin2",        { baz = "baz",               } }
    --:add { "plugin3",        { accessorFn = "getPlugin3", } }


--[[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀(ASCII ART GOES HERE)
--]]
