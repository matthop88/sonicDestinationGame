local JOT_REPOSITORY = requireRelative("lib/jotRepository")

return {
	create = function(self, jotObj)
		local jot = JOT_REPOSITORY:getJot(jotObj.name)

		if jot ~= nil then
			return jot:fromData(jotObj.data)
		end
	end,
}
