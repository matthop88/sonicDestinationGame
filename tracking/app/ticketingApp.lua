local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

print(TICKET_ID_UTIL:getNextID(__PARAMS["type"]))

love.event.quit()
