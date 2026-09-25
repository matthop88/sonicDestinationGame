local SERIALIZED_DATA = {
    create = function(self, objData)
        return ({
            objData       = objData,
            resultStrings = { "return {", },

            convert       = function(self)
                -- serialize array data in pairs
                for n, _ in ipairs(self.objData) do
                    if n % 2 == 0 then
                        table.insert(self.resultStrings, "    " .. self.objData[n - 1] .. ", " .. self.objData[n] .. ",")
                    elseif n == #self.objData then
                        table.insert(self.resultStrings, "    " .. self.objData[n]     .. ",")
                    end
                end

                table.insert(self.resultStrings, "    ")
                table.insert(self.resultStrings, "}")

                return self.resultStrings
            end,

        }):convert()
    end,
}

return {
    serialize = function(self, objData)
        return SERIALIZED_DATA:create(objData)
    end,

}
