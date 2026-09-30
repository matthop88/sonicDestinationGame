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
		local keyBlocksData = require(PATH_PREFIX .. "keyBlocksData")
		
		local serializedData = DATA_SERIALIZER:serialize(keyBlocksData)

		return ASSERT:TRUE("Key Blocks Data", self:compareWithFile(serializedData, PATH_PREFIX .. "keyBlocksData.lua"))
	
	end,

	testScribbleData = function(self)
		local scribbleData = require(PATH_PREFIX .. "scribbleData")
		
		local serializedData = DATA_SERIALIZER:serialize(scribbleData)

		return ASSERT:TRUE("Scribble Data", self:compareWithFile(serializedData, PATH_PREFIX .. "scribbleData.lua"))
	
	end,

	compareWithFile = function(self, serializedData, filename)
		local lines = self:readLinesFromFile(filename)

		serializedData:print()
		
		if serializedData:length() ~= #lines then
			print("ERROR: Line count mismatch. Serialized Data: " .. serializedData:length() .. ", File: " .. #lines)
			return false
		else
			for i = 1, #lines do
				if serializedData:get(i) ~= lines[i] then
					print("Error: Line mismatch on line #" .. i .. ", \"" .. serializedData:get(i) .. "\", should be \"" .. lines[i] .. "\"")
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
