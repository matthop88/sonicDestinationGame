local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

print(TICKET_ID_UTIL:getNextID(__PARAMS["type"]))

local template = require("tracking/app/templates/ticketMD")
love.system.setClipboardText(template)

print("Ticket template saved to clipboard.")

love.event.quit()
