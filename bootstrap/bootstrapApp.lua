--------------------------------------------------------------
--                     Bootstrap Utility                    --
--                        Version 0.1                       --
--                                                          --
--                 Functional Specifications                --
--                         INFR-0022                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Bootstrap Utility can be used to create skeletal structures for Plugins and Tools.

This ticket focuses specifically on Plugins.

Given a plugin name, this tool will create a folder inside plugins/modules/ corresponding with the plugin name, and also a .lua file inside the new folder corresponding with the plugin name.
The file will contain the basic structure of code for an empty plugin. If a ticket number is described, the file will also contain functional specifications in its comments.

                           Features
                           --------
- [X] Creation of infrastructure, command-line schema, outer main hookup
- [X] Empty folder and file created, if not already existent
- [X] Basic structure of code for empty plugin
- [X] Functional specifications in comments

--]]

if __PARAMS["pluginName"] then
	requireRelative("generation/plugin/pluginGenerator")
else
	print("\nNo generation modules available to run.\n")
end

love.event.quit()
