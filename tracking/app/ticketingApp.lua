if __PARAMS["commentOn"] then
	requireRelative("generateComments")
else
	requireRelative("generateTicket")
end

love.event.quit()
