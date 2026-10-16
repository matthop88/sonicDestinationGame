local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

print(TICKET_ID_UTIL:getNextID(__PARAMS["type"]))

local template = require("tracking/app/templates/ticketMD")
print(template)

love.event.quit()
