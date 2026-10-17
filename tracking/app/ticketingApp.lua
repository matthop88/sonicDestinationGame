local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id       = TICKET_ID_UTIL:getNextID(__PARAMS["prefix"])
local ID       = string.upper(id)

local date     = os.date("%Y-%m-%d")
local title    = __PARAMS["title"]
local type     = __PARAMS["type"]
local status   = __PARAMS["status"]
local priority = __PARAMS["priority"]
local points   = __PARAMS["points"]

local template = requireRelative("lib/templateFactory"):create("ticketMD")

love.system.setClipboardText(
	template:render { 
		id       = ID, 
		date     = date, 
		title    = title, 
		type     = type,
		status   = status,
		priority = priority,
		points   = points,
	}
)

print("Ticket template saved to clipboard (id = " .. id .. ")")

love.event.quit()

