--------------------------------------------------------------
--                     Bootstrap Utility                    --
--                        Version 0.2                       --
--                                                          --
--                 Functional Specifications                --
--                         INFR-0023                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Bootstrap Utility can be used to create skeletal structures for Plugins and Tools.

This ticket focuses specifically on Tools.

Given a tool name, this utility will create a folder inside tools/corresponding with 
the tool name. Inside of this folder will be a lua file named "{toolName}App.lua".
The file will contain the basic structure of code for an empty tool. 
If a ticket number is described, the file will also contain functional specifications in its comments.

In addition, a config folder will be created with a window and a cmdSchema.

For a tool name, separate words are allowed; the tool name used as a folder 
and the file name will be converted to Camel Case.

                           Features
                           --------
- [X] String Utility and tests written for Camel Case
- [X] Cmd Schema updated
- [ ] File tools extracted to general utility class
- [ ] Folder and file created
- [ ] Skeletal contents of file created
- [ ] Comments added to file if ticket number is described
- [ ] Config folder generated with cmdSchema and window

--]]

if __PARAMS["pluginName"] then
	requireRelative("generation/plugin/pluginGenerator")
else
	print("\nNo generation modules available to run.\n")
end

love.event.quit()
