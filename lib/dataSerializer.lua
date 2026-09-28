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

local prepareKVData = function(kvTable)
    local kvTableUppercase, kvTableLowercase = splitKVTable(kvTable, function(k) return STRING_UTIL:isUppercase(k) end)

    local sortedUppercaseTable = sortKVTable(kvTableUppercase)
    local sortedLowercaseTable = sortKVTable(kvTableLowercase)

    return joinTables(sortedUppercaseTable, sortedLowercaseTable)
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
                self:convertData(self.objData)
                
                self:addToResult("")
                self:addToResult("}")

                self:printResult()
                return self:getResult()
            end,

            convertData = function(self, data, indentString)
                indentString = indentString or "    "

                self:convertArrayData(data, indentString)
                self:convertKVData(data, indentString)
            end,

            convertArrayData = function(self, data, indentString)
                for n, _ in ipairs(data) do
                    if n % 2 == 0 and type(data[n - 1]) ~= "table" and type(data[n]) ~= "table" then
                        self:addToResult(indentString .. self:addQuotesIfString(data[n - 1]) .. ", " .. self:addQuotesIfString(data[n]) .. ",")
                    elseif type(data[n]) ~= "table" and n == #data then
                        self:addToResult(indentString .. self:addQuotesIfString(data[n])     .. ",")
                    elseif type(data[n]) == "table" then
                        self:addToResult(indentString .. "{")
                        self:convertData(data[n], indentString .. "    ")
                        self:addToResult(indentString .. "},")
                        if n ~= #data then
                            self:addToResult("")
                        end
                    end
                end
            end,

            convertKVData = function(self, kvData, indentString)
                local preparedKVData = prepareKVData(kvData)
                local maxKeyLength   = getMaxKeyLength(preparedKVData)

                for n, elt in ipairs(preparedKVData) do
                    local k, v = elt.key, elt.value
                    local paddingSize = maxKeyLength - string.len(k)
                    k = k .. string.rep(" ", paddingSize)

                    if type(v) == "table"  then 
                        if n > 1 then self:addToResult("") end
                        self:addToResult(indentString .. k .. " = {")
                        self:convertData(v, indentString .. "    ")
                        self:addToResult(indentString .. "},")
                    else
                        self:addToResult(indentString .. k .. " = " .. self:addQuotesIfString(v) .. ",")
                    end
                end
            end,

            addQuotesIfString = function(self, v)
                if type(v) == "string" then 
                    return "\"" .. v .. "\""
                else
                    return v
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
