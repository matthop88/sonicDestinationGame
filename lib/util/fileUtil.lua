local TERNARY     = require("lib/util/ternary")
local STRING_UTIL = require("game/util/stringUtil")

return {
	fileExists = function(self, path)
    	local file = io.open(path, "r")
	    if file ~= nil then
	        file:close()
	        return true
	    end
    	return false
    end,

	getSafeDestinationFilename = function(self, path, extension)
		local indexStr = STRING_UTIL:splitTail(path, "_")
		local index = TERNARY { IF = indexStr ~= "", THEN = tonumber(indexStr), ELSE = 0 } + 1

    	for i = index, 1000 do
    		local destFilename = path .. TERNARY { IF = i == 1, THEN = "", ELSE = "_" .. i } .. "." .. extension
    		if not self:fileExists(destFilename) then
    			return destFilename
    		end
    	end
    end,

    saveImageToCustomPath = function(self, imageData, fullFilePath)
    	local fileData = imageData:encode("png")

    	local file, err = io.open(fullFilePath, "wb")
	    if not file then
	        print("Failed to open file: " .. tostring(err))
	        return false
	    end
    
    	file:write(fileData:getString())
    	file:close()
    	return true
    end,
    
}
