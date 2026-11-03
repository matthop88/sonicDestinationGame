local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id       = TICKET_ID_UTIL:getNextID(__PARAMS["prefix"])

local date     = os.date("%Y-%m-%d")

local ellipses = [[
    ...
    ...
    ...]]

local title    = ""
if __PARAMS["objectName"] then
	title = "Implement " .. __PARAMS["objectName"]
end

local params = {
	id        = string.upper(id), 
	createdAt = date,
	updatedAt = date,
	title     = title,
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

