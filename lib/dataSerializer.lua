local SMART_STRING_LIST = {
    new = function()
        return {
            indentation = 0,

            data        = {},

            add         = function(self, myString)
                table.insert(self.data, string.rep(" ", self.indentation) .. myString)
            end,

            indent      = function(self)
                self.indentation = self.indentation + 4
            end,

            unindent    = function(self)
                self.indentation = self.indentation - 4
            end,

            length      = function(self)
                return #self.data
            end,

            get         = function(self, index)
                return self.data[index]
            end,

            print       = function(self)
                for _, str in ipairs(self.data) do
                    print(str)
                end
            end,
        }

    end,
}

local SMART_TABLE = {
    new = function()
        return {
            kvData        = {},
            arrayData     = {},

            maxKeyLength  = 0,

            addArrayEntry = function(self, n)
                table.insert(self.arrayData, n)
            end,

            addKVEntry    = function(self, k, v)
                if type(k) ~= "number" then
                    table.insert(self.kvData, { key = k, value = v })

                    self.maxKeyLength = math.max(self.maxKeyLength, string.len(k))
                end
            end,

            serialize     = function(self, serializedData)
                self:serializeArrayData(serializedData)
                self:serializeKVData(serializedData)
            end,

            serializeArrayData = function(self, serializedData)
                for n, v in ipairs(self.arrayData) do
                    if     n % 2 == 0    then
                        serializedData:add("" .. self.arrayData[n - 1] .. ", " .. self.arrayData[n] .. ",")
                    elseif n == #self.arrayData then
                        serializedData:add("" .. self.arrayData[n]     .. ",")
                    end
                end
            end,

            serializeKVData = function(self, serializedData)
                table.sort(self.kvData, function(a, b) return a.key < b.key end)

                for _, entry in ipairs(self.kvData) do
                    serializedData:add(self:padKey(entry.key) .. " = " .. self:quoteIfString(entry.value) .. ",")
                end
            end,

            padKey = function(self, k)
                return k .. string.rep(" ", self.maxKeyLength - string.len(k))
            end,

            quoteIfString = function(self, v)
                if type(v) == "string" then return "\"" .. v .. "\""
                else                        return         v          end
            end,

        }
    end,
}

return {
    serialize = function(self, dataObj)
        local serializedData = SMART_STRING_LIST.new()
        local smartTable     = SMART_TABLE.new()

        serializedData:add("return {")
        serializedData:indent()

        for _, v in ipairs(dataObj) do smartTable:addArrayEntry(v) end
        for k, v in  pairs(dataObj) do smartTable:addKVEntry(k, v) end

        smartTable:serialize(serializedData)

        serializedData:unindent()
        serializedData:add("}")

        return serializedData
    end,

}
