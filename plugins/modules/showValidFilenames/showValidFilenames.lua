--------------------------------------------------------------
--                  Show Valid Names Plugin                 --
--                         PLUG-0015                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Show Valid Names plugin, when provided with a directory path, file extension, and a condition, will show a list of all valid files meeting the criteria, and then exit LOVE2D.

                          Parameters
                          ----------
* filePath  - directory path where files are located
* extension - file extensions to filter by
* fileType  - word indicating what type of file; displayed in message "Valid {fileType} names are:". Defaults to "File".
* condition - the condition that must be met for this plugin to be executed.

Note: this plugin, once successfully run, performs a system exit.

--]]

local DIRECTORY_UTIL = require("lib/util/directoryUtil")

return {
    create = function(self, params)
        local FILE_PATH = params.filePath
        local EXTENSION = params.extension
        local FILE_TYPE = params.fileType or "File"

        local CONDITION = params.condition

        if (CONDITION()) then
            local validNames = DIRECTORY_UTIL:getFilesInDirectory(FILE_PATH, EXTENSION)
            print("\nValid " .. FILE_TYPE .. " names are:")
            print("------" .. string.rep("-", FILE_TYPE:len()) .. "-----------")
        
            for _, validName in ipairs(validNames) do print(validName) end
        
            print("")

            love.event.quit()
        end

        return {}
    end,
}
