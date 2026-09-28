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
        serializedData:add("360, 375,")
        serializedData:add("549, 387,")
        serializedData:add("600, 379,")
        serializedData:add("634, 378,")
        serializedData:unindent()
        serializedData:add("}")

        return serializedData
    end,

}
