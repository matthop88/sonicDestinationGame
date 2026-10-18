local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id       = TICKET_ID_UTIL:getNextID(__PARAMS["prefix"])

local date     = os.date("%Y-%m-%d")

local ellipses = [[
    ...
    ...
    ...]]

local params = {
	id        = string.upper(id), 
	createdAt = date,
	updatedAt = date,
	title     = __PARAMS["title"],
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
	history            = "- " .. date .. ": Created",
}

local template = requireRelative("lib/templateFactory"):create("ticketMD")

love.system.setClipboardText(template:render(params))

print("Ticket template saved to clipboard (id = " .. id .. ")")

love.event.quit()

