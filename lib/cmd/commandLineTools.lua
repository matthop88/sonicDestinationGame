local SCHEMA_LOADER  = require("lib/cmd/schemaLoader")
local PARAMS_BUILDER = require("lib/cmd/paramsBuilder")
local HELP_SYSTEM    = require("lib/cmd/helpSystem")

return {
    create = function(self, appDirectory, testMode)
        return {
            SCHEMA     = SCHEMA_LOADER:loadSchema(appDirectory),
            testMode   = testMode,

            getParams = function(self, args)
                if not HELP_SYSTEM:respondToHelp(args, self.SCHEMA) then
                    local params = PARAMS_BUILDER:build(args, self.SCHEMA)
                    if self.testMode or self:validateParams(params) then
                        return params
                    end
                end
        	end,

            validateParams = function(self, params)
                local incorrectValues = self:findIncorrectValues(params)

                if incorrectValues then
                    for k, v in pairs(incorrectValues) do
                        self:generateHelpError("ERROR! Incorrect value for " .. k .. ": " .. v)
                        return false
                    end
                end

                return self:validateNoParamsMissing(params)
            end,

            findIncorrectValues = function(self, params)
                for k, v in pairs(params) do
                    local validValues = self.SCHEMA.COMMANDS[k].values
                    if validValues and not self:isValueInList(v, validValues) then
                        local incorrectValues = {}
                        incorrectValues[k] = v
                        return incorrectValues
                    end
                end
            end,
                
            validateNoParamsMissing = function(self, params)
                local missingParams = self:findMissingParams(params)

                if #missingParams > 0 then
                    self:generateHelpError(function() self:printOutMissingParams(missingParams) end)
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

            generateHelpError = function(self, error)
                if type(error) == "function" then
                    error()
                else
                    print("\n" .. error) 
                end

                love.event.quit()
                print(HELP_SYSTEM:generateHelp(self.SCHEMA))
            end,
                        
            generateHelp = function(self)
                return HELP_SYSTEM:generateHelp(self.SCHEMA)
            end,

            isValueInList = function(self, v, list)
                for _, value in ipairs(list) do
                    if v == value then return true end
                end

                return false
            end,

        }
    end,

}
