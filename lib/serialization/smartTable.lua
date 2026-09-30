local STRING_UTIL = require("game/util/stringUtil")

local SMART_TABLE

SMART_TABLE = {
    ingest = function(self, dataObj)
        return ({
            kvData        = {},
            arrayData     = {},

            maxKeyLength  = 0,

            caption       = nil,

            init          = function(self, dataObj)
                for _, v in ipairs(dataObj) do self:addArrayEntry(v) end
                for k, v in  pairs(dataObj) do self:addKVEntry(k, v) end

                return self
            end,

            addArrayEntry = function(self, n)
                if type(n) == "table" then
                    table.insert(self.arrayData, SMART_TABLE:ingest(n))
                else
                    table.insert(self.arrayData, n)
                end
            end,

            addKVEntry    = function(self, k, v)
                if type(k) ~= "number" then
                    if type(v) == "table" then
                        table.insert(self.kvData, { key = k, value = SMART_TABLE:ingest(v) })
                    elseif type(k) == "string" and STRING_UTIL:isUppercase(k) and self.caption == nil then
                        self.caption = { key = k, value = v }
                    elseif type(v) ~= "function" then
                        table.insert(self.kvData, { key = k, value = v })
                    end

                    self.maxKeyLength = math.max(self.maxKeyLength, string.len(k))
                end
            end,

            serialize     = function(self, serializedData)
                self:serializeCaption(serializedData)
                self:serializeArrayData(serializedData)
                self:serializeKVData(serializedData)
            end,

            serializeCaption = function(self, serializedData)
                if self.caption then
                    local serializedCaption = self:padKey(self.caption.key) .. " = " .. self:quoteIfString(self.caption.value) .. ","
                    if serializedData:length() == 1 then
                        serializedData:add(serializedCaption)
                        serializedData:add("")
                    else
                        serializedData:append("   " .. self:padKey(self.caption.key) .. " = " .. self:quoteIfString(self.caption.value) .. ",")
                    end
                end
            end,

            serializeArrayData = function(self, serializedData)
                for n, v in ipairs(self.arrayData) do
                    if type(v) == "table" then self:serializeArrayTable(v, serializedData)
                    else                       self:serializeArrayElements(n, serializedData) end
                end
            end,

            serializeArrayTable = function(self, t, serializedData)
                serializedData:add("{")
                serializedData:indent()
                t:serialize(serializedData)
                serializedData:unindent()
                serializedData:add("},")
                serializedData:add("")
            end,

            serializeArrayElements = function(self, n, serializedData)
                if     n % 2 == 0    then
                    serializedData:add("" .. self.arrayData[n - 1] .. ", " .. self.arrayData[n] .. ",")
                elseif n == #self.arrayData then
                    serializedData:add("" .. self.arrayData[n]     .. ",")
                end
            end,

            serializeKVData = function(self, serializedData)
                table.sort(self.kvData, function(a, b) return a.key < b.key end)

                for n, entry in ipairs(self.kvData) do
                    if type(entry.value) == "table" then
                        self:serializeKVTable(n, entry, serializedData)
                    else
                        serializedData:add(self:padKey(entry.key) .. " = " .. self:quoteIfString(entry.value) .. ",")
                    end
                end
            end,

            serializeKVTable = function(self, n, entry, serializedData)
                if n > 1 then serializedData:add("") end
                serializedData:add(self:padKey(entry.key) .. " = {")
                serializedData:indent()
                entry.value:serialize(serializedData)
                serializedData:unindent()
                serializedData:add("},")
            end,

            padKey = function(self, k)
                return k .. string.rep(" ", self.maxKeyLength - string.len(k))
            end,

            quoteIfString = function(self, v)
                if type(v) == "string" then return "\"" .. v .. "\""
                else                        return         v          end
            end,

        }):init(dataObj)
    end,
}

return SMART_TABLE
