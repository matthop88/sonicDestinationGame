if __PARAMS["commentOn"] then
	requireRelative("generateComments")
else
	if __PARAMS["objectName"] == "_" then
		local objectNames = requireRelative("lib/ticketIDUtil"):getAllObjectNames()
		print("\nList of Object Names:")
		print("---------------------")
		for _, name in ipairs(objectNames) do
			print(name)
		end
		print("")
	else
		requireRelative("generateTicket")
	end
end

love.event.quit()
