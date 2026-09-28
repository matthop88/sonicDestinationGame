local STRING_UTIL = require("game/util/stringUtil")       

local splitKVTable = function(kvTable, meetsCriteriaFn)
    local kvTable1, kvTable2 = {}, {}
    
    for k, v in pairs(kvTable) do
        if type(k) == "string" then
            if meetsCriteriaFn(k) then kvTable1[k] = v
            else                       kvTable2[k] = v   end
        end
    end

    return kvTable1, kvTable2
end

local orderKVTable = function(kvTable)
    local orderedKVTable = {}

    for k, v in pairs(kvTable) do
        if type(k) == "string" then
            table.insert(orderedKVTable, { key = k, value = v })
        end
    end

    return orderedKVTable
end

local sortKVTable = function(kvTable)
    local data = orderKVTable(kvTable)

    table.sort(data, function(a, b) return a.key < b.key end)

    return data
end

local joinTables = function(t1, t2)
    local resultingTable = {}

    for _, e in ipairs(t1) do table.insert(resultingTable, e) end
    for _, e in ipairs(t2) do table.insert(resultingTable, e) end

    return resultingTable
end         

local prepareKVData = function(kvData)
    local kvDataUppercase, kvDataLowercase = splitKVTable(kvData, function(k) return STRING_UTIL:isUppercase(k) end)

    local sortedUppercaseData = sortKVTable(kvDataUppercase)
    local sortedLowercaseData = sortKVTable(kvDataLowercase)

    return joinTables(sortedUppercaseData, sortedLowercaseData)
end

local getMaxKeyLength = function(orderedKVData)
    local maxKeyLength = 0
    for _, elt in ipairs(orderedKVData) do
        maxKeyLength = math.max(maxKeyLength, string.len(elt.key))
    end

    return maxKeyLength
end

local SERIALIZED_DATA = {
    create = function(self, objData)
        return ({
            objData       = objData,
            resultStrings = { "return {", },

            convert       = function(self)
                self:convertArrayData()
                self:convertKVData()

                self:addToResult("    ")
                self:addToResult("}")

                self:printResult()
                return self:getResult()
            end,

            convertArrayData = function(self)
                for n, _ in ipairs(self.objData) do
                    if n % 2 == 0 then
                        self:addToResult("    " .. self.objData[n - 1] .. ", " .. self.objData[n] .. ",")
                    elseif n == #self.objData then
                        self:addToResult("    " .. self.objData[n]     .. ",")
                    end
                end
            end,

            convertKVData = function(self)
                local preparedKVData = prepareKVData(self.objData)
                local maxKeyLength   = getMaxKeyLength(preparedKVData)

                for _, elt in ipairs(preparedKVData) do
                    local k, v = elt.key, elt.value
                    if type(v) == "string" then v = "\"" .. v .. "\"" end
                    local paddingSize = maxKeyLength - string.len(k)
                    self:addToResult("    " .. k .. string.rep(" ", paddingSize) .. " = " .. v .. ",")
                end
            end,

            addToResult = function(self, line)
                table.insert(self.resultStrings, line)
            end,

            getResult   = function(self)
                return self.resultStrings
            end,

            printResult = function(self)
                for _, s in ipairs(self.resultStrings) do
                    print(s)
                end
            end,

        }):convert()
    end,
}

return {
    serialize = function(self, objData)
        return SERIALIZED_DATA:create(objData)
    end,

}
