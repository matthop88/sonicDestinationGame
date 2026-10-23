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
