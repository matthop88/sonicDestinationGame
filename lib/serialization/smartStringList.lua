local FILESYSTEM  = love.filesystem
local STRING_UTIL = require("game/util/stringUtil")

return {
    new = function()
        return {
            indentation = 0,

            data        = {},

            add         = function(self, myString, params)
                if params == nil then self:addRaw(myString)
                else                  self:addParameterized(myString, params) end
            end,

            addRaw      = function(self, myString)
                table.insert(self.data, string.rep(" ", self.indentation) .. myString)
            end,

            addKV       = function(self, key, value, params)
                if not STRING_UTIL:endsWith(value, "{") then value = STRING_UTIL:addQuotesIfString(value) .. "," end
                
                self:addParameterized(STRING_UTIL:padValueRight(key, params.maxKeyLength or 0) .. " = " .. value, params)
            end,

            addParameterized = function(self, myString, params)
                if params.unindent  then self:unindent()       end

                if params.prefix    then myString = params.prefix .. myString end

                if params.append    then self:append(myString)
                else                     self:addRaw(myString) end

                if params.indent    then self:indent()         end
                if params.lineBreak then self:addRaw("")       end
            end,

            enrichMyString = function(self, myString, params)
                if params.prefix then
                    myString = params.prefix .. myString
                end

                return myString
            end,

            append      = function(self, myString)
                self.data[#self.data] = self.data[#self.data] .. myString
            end,

            indent      = function(self) self.indentation = self.indentation + 4 end,
            unindent    = function(self) self.indentation = self.indentation - 4 end,

            length      = function(self)        return #self.data                end,
            get         = function(self, index) return self.data[index]          end,

            print       = function(self)
                for _, str in ipairs(self.data) do
                    print(str)
                end
            end,

            writeToFile = function(self, path, filename)
                local content = table.concat(self.data, "\n")

                FILESYSTEM.createDirectory(path)
        
                local filePath = path .. "/" .. filename .. ".lua"
                return self:fileSystemWrite(filePath, content)
            end,

            fileSystemWrite = function(self, filePath, content)
                local success, message = FILESYSTEM.write(filePath, content)
        
                if success then
                    message = "File saved successfully to " .. FILESYSTEM.getSaveDirectory() .. "/" .. filePath
                else
                    message = "Error saving file: " .. tostring(message)
                end

                return success, message
            end,
        }

    end,
}
