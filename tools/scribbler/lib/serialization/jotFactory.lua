local JOT_REPOSITORY = requireRelative("lib/serialization/jotRepository")

return {
	create = function(self, jotObj)
		local jot = JOT_REPOSITORY:getJot(jotObj.name)

		if jot ~= nil then
			return jot:fromDataObj(jotObj)
		end
	end,
}
