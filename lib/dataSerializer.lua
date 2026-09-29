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

return {
    serialize = function(self, dataObj)
        local serializedData = SMART_STRING_LIST:create()

        serializedData:add("return {")
        serializedData:indent()
        -- Start with just number array data
        
        for n, v in ipairs(dataObj) do
            if n % 2 == 0 then
                serializedData:add("" .. dataObj[n - 1] .. ", " .. dataObj[n] .. ",")
            elseif n == #dataObj then
                serializedData:add("" .. dataObj[n]     .. ",")
            end
        end

        for k, v in pairs(dataObj) do
            if type(k) ~= "number" then
                serializedData:add(k .. " = " .. v)
            end
        end

        serializedData:unindent()
        serializedData:add("}")

        return serializedData
    end,

}
