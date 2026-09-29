local SMART_STRING_LIST = {
    create = function(self)
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
    create = function(self)
        return {
            kvData        = {},

            arrayData     = {},

            addArrayEntry = function(self, n)
                table.insert(self.arrayData, n)
            end,

            addKVEntry    = function(self, k, v)
                if type(k) ~= "number" then
                    table.insert(self.kvData, { key = k, value = v })
                end
            end,

            serialize     = function(self, serializedData)
                for n, v in ipairs(self.arrayData) do
                    if     n % 2 == 0    then
                        serializedData:add("" .. self.arrayData[n - 1] .. ", " .. self.arrayData[n] .. ",")
                    elseif n == #self.arrayData then
                        serializedData:add("" .. self.arrayData[n]     .. ",")
                    end
                end
        
                for _, entry in ipairs(self.kvData) do
                    serializedData:add(entry.key .. " = " .. entry.value)
                end
            end,

        }
    end,
}

return {
    serialize = function(self, dataObj)
        local serializedData = SMART_STRING_LIST:create()
        local smartTable     = SMART_TABLE:create()

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
