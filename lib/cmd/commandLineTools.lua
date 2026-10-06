local ERROR_LOGGER = require("game/error/errorLogger")

local getSchema = function(path)
    local cmdSchema

    local status, err = pcall(function() cmdSchema = require(path .. "/cmdSchema") end)

    if status == true then
        return cmdSchema
    else
        ERROR_LOGGER:logError("Command Schema not found for path " .. path .. "!")
        return nil
    end
end

local DEFAULT_SCHEMA = {
    VERSION = 0.0,
    
    COMMANDS = {
        
    },
}

local PARAMS_BUILDER = require("lib/cmd/paramsBuilder")

return {
    create = function(self, appDirectory)
        return {
            SCHEMA     = getSchema(appDirectory) or DEFAULT_SCHEMA,

            getParams = function(self, args)
                local params = PARAMS_BUILDER:build(args, self.SCHEMA)

                self:validateParams(params)

                return params
        	end,

            validateParams = function(self, params)
                local missingParams = self:findMissingParams(params)

                if #missingParams > 0 then
                    self:printOutMissingParams(missingParams)
                    love.event.quit()
                end
            end,

            findMissingParams = function(self, params)
                local missingParams = {}

                for k, v in pairs(self.SCHEMA.COMMANDS) do
                    if v.required and params[k] == nil then
                        table.insert(missingParams, k)
                    end
                end

                return missingParams
            end,

            printOutMissingParams = function(self, params)
                print("\nERROR! The following parameters are missing:")
                for _, p in ipairs(params) do
                    self:printOutMissingParam(p)
                end

                print("\n")
            end,

            printOutMissingParam = function(self, p)
                local s = p
                if self.SCHEMA.COMMANDS[p].shortcut then
                    s = s .. " (shortcut: '-" .. self.SCHEMA.COMMANDS[p].shortcut .. "')"
                end
                print(s)
            end,

            expandShortcut = function(self, shortcut)
                return PARAMS_BUILDER:expandShortcut(shortcut, self.SCHEMA)
            end,

            respondToHelp = function(self, args)
                for _, arg in ipairs(args) do
                    if arg == "--help" or arg == "-h" then
                        print(self:generateHelp())
                        love.event.quit()
                    end
                end
            end,

            generateHelp = function(self)
                local helpString = "\n\nAccepted commands include:\n"
                helpString = helpString .. "  --help,                      -h  Show this help.\n"

                local keys = {}
                for k, v in pairs(self.SCHEMA.COMMANDS) do
                    table.insert(keys, k)
                end

                table.sort(keys)

                for _, k in pairs(keys) do
                    local v = self.SCHEMA.COMMANDS[k]
                    helpString = helpString .. "  --" .. k .. "," .. string.rep(" ", 20 - string.len(k)) .. "      -" .. v.shortcut .. "  " .. v.description .. "\n"
                end
                return helpString
            end,

        }
    end,

}
