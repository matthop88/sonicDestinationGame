local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")
local LINE_JOT     = requireRelative("lib/jots/line")
local TEXT_JOT     = requireRelative("lib/jots/text")

return {
	create = function(self, jotObj)
		if     jotObj.name == "scribble" then return SCRIBBLE_JOT:fromData(jotObj.data)
		elseif jotObj.name == "line"     then return LINE_JOT:fromData(jotObj.data)
		elseif jotObj.name == "text"     then return TEXT_JOT:fromData(jotObj.data)
		end
	end,
}
