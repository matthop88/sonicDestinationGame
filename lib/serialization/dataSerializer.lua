local SMART_STRING_LIST = require("lib/serialization/smartStringList")
local SMART_TABLE       = require("lib/serialization/smartTable")

return {
    serialize = function(self, dataObj)
        local serializedData = SMART_STRING_LIST.new()
        local smartTable     = SMART_TABLE:ingest(dataObj)

        serializedData:add("return {")
        serializedData:indent()

        smartTable:serialize(serializedData)

        serializedData:unindent()
        serializedData:add("}")

        return serializedData
    end,

}
