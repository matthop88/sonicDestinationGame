--------------------------------------------------------------
--                 Functional Specifications                --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
    Can make simple, single-color drawings or "scribblings",
    with undo/redo functionality and saving and loading from disk.
    Stretch goal: straight line, rectangle and text support

                           Features
                           --------
        [ ] Mouse-down draws lines between mouse position 
            and previous mouse position
        [ ] Mouse-up allows movement without drawing
        [ ] Command Z undoes one action at a time
        [ ] Shift Command Z redoes one action at a time
        [ ] 'G' shows a grid
        [ ] Shift allows snapping to grid
        [ ] File name entered as command-line parameter
            loads from file
        [ ] Command-S saves to disk in custom object format
        [ ] Command-Option-S saves to disk via image capture
        
                         Stretch Goals
                         -------------
        [ ] 'L' draws a line from pt 1 to pt 2; 
                can be used to create polygons
        [ ] 'R' draws a rect with upper-left corner at pt 1, 
            lower left at pt 2
        [ ] 'T' allows typing of text at mouse position.
            Left-justified
        [ ] 'C' allows cycling through various colors

--]]
