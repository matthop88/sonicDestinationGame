return {
    serialize = function(self, objData)
        local resultStrings = {
            "return {",
        }

        -- first, let's try with array data
        -- write elements in pairs
        for n, _ in ipairs(objData) do
            if n % 2 == 0 then
                table.insert(resultStrings, "    " .. objData[n - 1] .. ", " .. objData[n] .. ",")
            elseif n == #objData then
                table.insert(resultStrings, "    " .. objData[n]     .. ",")
            end
        end

        table.insert(resultStrings, "    ")
        table.insert(resultStrings, "}")

        return resultStrings

    end,

}
