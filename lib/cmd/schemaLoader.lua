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
            if v.values and v.default and not self:isValueInList(v.default, v.values) then
                table.insert(v.values, v.default)
            end
        end

        return schema
    end,

    isValueInList = function(self, v, list)
        for _, value in ipairs(list) do
            if v == value then return true end
        end

        return false
    end,
}
