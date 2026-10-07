local STRING_UTIL  = require("game/util/stringUtil")

return {
	respondToHelp = function(self, args, schema)
        for _, arg in ipairs(args) do
            if arg == "--help" or arg == "-h" then
                print(self:generateHelp(schema))
                love.event.quit()
                return true
            end
        end
    end,

    generateHelp = function(self, schema)
        local keys = self:getSortedKeys(schema)

        if self:isHelpValid(schema, keys) then
            return self:generateValidHelp(schema, keys)
        else
            return self:generateInvalidHelp(schema, keys)
        end
    end,

    getSortedKeys = function(self, schema)
        local keys = {}
        for k, v in pairs(schema.COMMANDS) do
            table.insert(keys, k)
        end

        table.sort(keys)

        return keys
    end,

    isHelpValid = function(self, schema, keys)
        for _, k in pairs(keys) do
            local v = schema.COMMANDS[k]
            if not v.description then return false end
        end

        return true
    end,

    generateValidHelp = function(self, schema, keys)
        local helpString = self:generateHelpHeader()

        for _, k in pairs(keys) do
            local v = schema.COMMANDS[k]
            helpString = helpString .. "  --" .. k .. "," .. string.rep(" ", 20 - string.len(k)) .. "      -" .. v.shortcut .. "  " .. self:generateDescription(v) .. "\n"
            if v.default  then helpString = helpString .. string.rep(" ", 35) .. "(Default value: " .. STRING_UTIL:addQuotesIfString(v.default) .. ")\n\n" end
        end
        return helpString
    end,

    generateHelpHeader = function(self)
        return "\nAccepted commands include:\n" ..
                 "  --help,                      -h  Show this help.\n"
    end,

    generateDescription = function(self, v)
        local required = v.required and not v.default

        if type(v.description) == "table" then
            return self:generateMultiLineDescription(v.description, required)
        else
            if required then return v.description .. "\n    [REQUIRED]\n"
            else             return v.description                     end
        end
    end,

    generateMultiLineDescription = function(self, description, required)
        local descriptionString = ""

        for n, line in ipairs(description) do
            if     n == 1              then descriptionString = descriptionString .. line .. "\n"
            elseif n == 2 and required then descriptionString = descriptionString .. "    [REQUIRED]" .. string.rep(" ", 21) .. line .. "\n"   
            else                            descriptionString = descriptionString .. string.rep(" ", 35) .. line .. "\n"               end
        end

        return descriptionString
    end,

    generateInvalidHelp = function(self, schema, keys)
        local helpString = "\nXXX The following commands lack documentation:\n"

        for _, k in pairs(keys) do
            local v = schema.COMMANDS[k]
            if not v.description then
                helpString = helpString .. "  --" .. k .. "," .. string.rep(" ", 20 - string.len(k)) .. "      -" .. v.shortcut .. "\n"
            end
        end
        return helpString
    end,
}
