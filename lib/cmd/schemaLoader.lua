local SMART_LIST     = require("lib/util/smartList")

local DEFAULT_SCHEMA = {
    VERSION = 0.0,
    
    COMMANDS = {
        
    },
}

return {
    loadSchema = function(self, path)
        local cmdSchema

        local status, err = pcall(function() cmdSchema = require(path .. "/cmdSchema") end)

        if status == true then
            return self:normalizeSchema(cmdSchema)
        else
            return DEFAULT_SCHEMA
        end
    end,

    normalizeSchema = function(self, schema)
        for k, v in pairs(schema.COMMANDS) do
            if v.values then
                self:normalizeValues(v)
            end
        end

        return schema
    end,

    normalizeValues = function(self, v)
        v.values = SMART_LIST:create(v.values)

        if v.default and not v.values:contains(v.default) then
            table.insert(v.values, v.default)
        end
    end,
}
