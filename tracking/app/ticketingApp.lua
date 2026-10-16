local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id    = TICKET_ID_UTIL:getNextID(__PARAMS["type"])
local ID    = string.upper(id)

local date  = os.date("%Y-%m-%d")
local title = __PARAMS["title"]

local template = requireRelative("lib/templateFactory"):create("ticketMD")

love.system.setClipboardText(template:render { id = ID, date = date, title = title })

print("Ticket template saved to clipboard (id = " .. id .. ")")

love.event.quit()

