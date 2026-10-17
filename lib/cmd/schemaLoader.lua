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
            return cmdSchema
        else
            return DEFAULT_SCHEMA
        end
    end,
}
