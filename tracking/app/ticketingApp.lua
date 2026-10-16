local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

local id = TICKET_ID_UTIL:getNextID(__PARAMS["type"])

local template = requireRelative("lib/templateFactory"):create("ticketMD")

love.system.setClipboardText(template:render { id = id })

print("Ticket template saved to clipboard.")

love.event.quit()

