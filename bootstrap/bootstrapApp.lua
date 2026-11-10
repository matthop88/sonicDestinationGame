if __PARAMS["pluginName"] then
	requireRelative("generation/plugin/pluginGenerator")
else
	print("\nNo generation modules available to run.\n")
end

love.event.quit()
