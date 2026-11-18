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
    	for index = 1, 1000 do
    		local destFilename = path .. TERNARY { IF = index == 1, THEN = "", ELSE = "_" .. index } .. "." .. extension
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
