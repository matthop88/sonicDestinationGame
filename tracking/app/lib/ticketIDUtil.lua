local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")
local ternary        = require("lib/util/ternary")

local id       = TICKET_ID_UTIL:getNextID(__PARAMS["prefix"])

local date     = os.date("%Y-%m-%d")

local ellipses = [[
    ...
    ...
    ...]]

local getAction = function(objectName)
	return ternary { IF   = TICKET_ID_UTIL:findObjectName(objectName),
					 THEN = "Upgrade ",
					 ELSE = "Implement " }
end

local getTitle   = function(objectName)
	return ternary { IF   = objectName ~= nil, 
				     THEN = getAction(objectName) .. objectName,
				     ELSE = __PARAMS["title"] }  
end     

local params = {
	id        = string.upper(id), 
	createdAt = date,
	updatedAt = date,
	title     = getTitle(__PARAMS["objectName"]),
	objectName= __PARAMS["objectName"],
	version   = "0.1",
	type      = __PARAMS["type"],
	status    = __PARAMS["status"],
	priority  = __PARAMS["priority"],
	points    = __PARAMS["points"],
	summary   = ellipses,
	details   = "See acceptance criteria.",
	acceptanceCriteria = [[
- [ ] Criteria #1
- [ ] Criteria #2
- [ ] Criteria #3]],
	notes              = ellipses,
	parameters         = [[
* parameter1 - description
* parameter2 - description
* parameter3 - description]],
	history            = "- " .. date .. ": Created",
}

local template
if __PARAMS["prefix"] == "plug" then
	template = requireRelative("lib/templateFactory"):create("pluginTicketMD")
else
	template = requireRelative("lib/templateFactory"):create("ticketMD")
end

love.system.setClipboardText(template:render(params))

print("Ticket template saved to clipboard (id = " .. id .. ")")

