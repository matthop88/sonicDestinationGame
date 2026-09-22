local ASSERT          = require("test/lib/assert")

local DATA_SERIALIZER = require("lib/dataSerializer")

local PATH_PREFIX     = "test/tests/resources/dataSerializer/"

return {
	NAME             = "DataSerializer",

	testArrayData    = function(self)
		local arrayData = require(PATH_PREFIX .. "arrayData")
		
		--local serializedData = DATA_SERIALIZER:serialize(arrayData)

		local serializedData = { "return {",
								 "    360, 375,",
								 "    549, 387,",
								 "    600, 379,",
								 "    634, 378,",
								 "}",
								}


		return ASSERT:TRUE("Array Data", self:compareWithFile(serializedData, PATH_PREFIX .. "arrayData.lua"))
	end,

	testKVData       = function(self)

	end,

	testKeyBlocks    = function(self)

	end,

	testScribbleData = function(self)

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
