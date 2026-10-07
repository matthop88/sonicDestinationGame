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
local HELP_SYSTEM    = require("lib/cmd/helpSystem")

return {
    create = function(self, appDirectory)
        return {
            SCHEMA     = getSchema(appDirectory) or DEFAULT_SCHEMA,

            getParams = function(self, args)
                if not HELP_SYSTEM:respondToHelp(args, self.SCHEMA) then
                    local params = PARAMS_BUILDER:build(args, self.SCHEMA)
                    if self:validateParams(params) then
                        return params
                    end
                end
        	end,

            validateParams = function(self, params)
                local missingParams = self:findMissingParams(params)

                if #missingParams > 0 then
                    self:printOutMissingParams(missingParams)
                    love.event.quit()
                    print(HELP_SYSTEM:generateHelp(self.SCHEMA))
                    return false
                end

                return true
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

        }
    end,

}
