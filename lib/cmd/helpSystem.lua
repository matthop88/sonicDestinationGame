return {
	respondToHelp = function(self, args, schema)
        for _, arg in ipairs(args) do
            if arg == "--help" or arg == "-h" then
                print(self:generateHelp(schema))
                love.event.quit()
            end
        end
    end,

    generateHelp = function(self, schema)
        local helpString = "\n\nAccepted commands include:\n"
        helpString = helpString .. "  --help,                      -h  Show this help.\n"

        local keys = self:getSortedKeys(schema)

        for _, k in pairs(keys) do
            local v = schema.COMMANDS[k]
            helpString = helpString .. "  --" .. k .. "," .. string.rep(" ", 20 - string.len(k)) .. "      -" .. v.shortcut .. "  " .. v.description .. "\n"
        end
        return helpString
    end,

    getSortedKeys = function(self, schema)
    	local keys = {}
        for k, v in pairs(schema.COMMANDS) do
            table.insert(keys, k)
        end

        table.sort(keys)

        return keys
    end,

}
