local ASSERT          = require("test/lib/assert")

local DATA_SERIALIZER = require("lib/dataSerializer")

local PATH_PREFIX     = "test/tests/resources/dataSerializer/"

return {
	NAME             = "DataSerializer",

	testArrayData    = function(self)
		local arrayData = require(PATH_PREFIX .. "arrayData")
		
		local serializedData = DATA_SERIALIZER:serialize(arrayData)

		return ASSERT:TRUE("Array Data", self:compareWithFile(serializedData, PATH_PREFIX .. "arrayData.lua"))
	end,

	testKVData       = function(self)
		local kvData = require(PATH_PREFIX .. "kvData")
		
		local serializedData = DATA_SERIALIZER:serialize(kvData)

		return ASSERT:TRUE("K/V Data", self:compareWithFile(serializedData, PATH_PREFIX .. "kvData.lua"))
	
	end,

	testKeyBlocks    = function(self)
		local keyBlocksData = require(PATH_PREFIX .. "keyBlocks")
		
		local serializedData = DATA_SERIALIZER:serialize(keyBlocksData)

		return ASSERT:TRUE("Key Blocks Data", self:compareWithFile(serializedData, PATH_PREFIX .. "keyBlocksData.lua"))
	
	end,

	testScribbleData = function(self)
		local arrayData = require(PATH_PREFIX .. "scribbleData")
		
		local serializedData = DATA_SERIALIZER:serialize(scribbleData)

		return ASSERT:TRUE("Scribble Data", self:compareWithFile(serializedData, PATH_PREFIX .. "scribbleData.lua"))
	
	end,

	compareWithFile = function(self, serializedData, filename)
		local lines = self:readLinesFromFile(filename)

		if #serializedData ~= #lines then
			print("ERROR: Line count mismatch. Serialized Data: " .. #serializedData .. ", File: " .. #lines)
			return false
		else
			for i = 1, #lines do
				if serializedData[i] ~= lines[i] then
					print("Error: Line mismatch on line #" .. i .. ", \"" .. serializedData[i] .. "\", should be \"" .. lines[i] .. "\"")
					return false
				end
			end
		end

		return true
    end,

    readLinesFromFile = function(self, filename)
		local lines = {}

    	if love.filesystem.getInfo(filename) then
        	for line in love.filesystem.lines(filename) do
            	table.insert(lines, line)
        	end
    	end

    	return lines
    end,
    
}
