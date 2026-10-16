local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id   = TICKET_ID_UTIL:getNextID(__PARAMS["type"])
local ID   = string.upper(id)

local date = os.date("%Y-%m-%d")

local template = requireRelative("lib/templateFactory"):create("ticketMD")

love.system.setClipboardText(template:render { id = ID, date = date })

print("Ticket template saved to clipboard (id = " .. id .. ")")

love.event.quit()

