local TICKET_ID_UTIL  = requireRelative("lib/ticketIDUtil")
local STRING_UTIL     = require("game/util/stringUtil")
local ternary         = require("lib/util/ternary")
	
local TEMPLATE_PARSER = requireRelative("lib/templateParser")

local TICKET_GENERATOR = ({
	
	ELLIPSES = [[
    ...
    ...
    ...]],

	init = function(self, params)
		self.params = params
		self.objectFilename = TICKET_ID_UTIL:findObjectName(self.params.objectName)
		self:generateObjectKVTable()
		self:generatePrefix()
		self:generateID()
		self:generateDate()
		self:generateTitle()
		self:generateVersion()
		self:generateLabels()
		self:generateSummary()
		self:generateDetails()
		self:generateAcceptanceCriteria()
		self:generateNotes()
		self:generateParameters()
		self:generateHistory()

		return self
	end,

	generateObjectKVTable = function(self)
		if self.objectFilename then
			local data, size = love.filesystem.read(self.objectFilename .. ".md")

			local templateParser = TEMPLATE_PARSER:create("pluginTicketMD")
			self.objectKVTable   = templateParser:parse(data)
		end
	end,

	generatePrefix = function(self)
		if self.objectFilename then
			self.params.prefix = STRING_UTIL:dropSuffix(STRING_UTIL:dropPrefix(self.objectFilename, string.len(self.objectFilename) - 9), 5)
		end 
	end,

	generateID = function(self)
		self.ticketFilename = TICKET_ID_UTIL:getNextID(self.params.prefix)
		self.params.id = string.upper(self.ticketFilename)
	end,

	generateDate = function(self)
		self.date = os.date("%Y-%m-%d")
		self.params.createdAt = self.date
		self.params.updatedAt = self.date
	end,

	generateTitle = function(self)
		self.params.title = ternary { IF   = self.objectFilename,
						   			  THEN = "Upgrade ",
						   			  ELSE = "Implement " } .. self.params.objectName
	end,

	generateVersion = function(self)
		if self.objectKVTable then
			self.params.version = "" .. (tonumber(self.objectKVTable["version"]) + 0.1)
		else
			self.params.version = "0.1"
		end
	end,

	generateLabels = function(self)
		if self.objectKVTable then
			self.params.labels = self.objectKVTable["labels"]
		else
			self.params.labels = ""
		end
	end,

	generateSummary = function(self)
		self.params.summary = self.ELLIPSES
	end,

	generateDetails = function(self)
		self.params.details = "See acceptance criteria."
	end,

	generateAcceptanceCriteria = function(self)
		self.params.acceptanceCriteria = [[
- [ ] Criteria #1
- [ ] Criteria #2
- [ ] Criteria #3]]
	end,

	generateNotes = function(self)
		self.params.notes = self.ELLIPSES
	end,

	generateParameters = function(self)
		if self.objectKVTable then
			self.params.parameters = self.objectKVTable["parameters"]
		else
			self.params.parameters = [[
* parameter1 - description
* parameter2 - description
* parameter3 - description]]
		end
	end,

	generateHistory = function(self)
		self.params.history = "- " .. self.date .. ": Created"
	end,

	render = function(self)
		local template = ternary { 
							IF   = self.params.prefix == "plug",
							THEN = requireRelative("lib/templateFactory"):create("pluginTicketMD"),
							ELSE = requireRelative("lib/templateFactory"):create("ticketMD")
						 }

		local filename = "tracking/tickets/active/" .. self.ticketFilename .. ".md"
		local file, err = io.open(filename, "w")

		if file then
			file:write(template:render(self.params))
		   	file:close() 

		  	print("Ticket saved to " .. filename)
		else
			print("Error when writing ticket to " .. filename)
		end
	end,

}):init {
	prefix     = __PARAMS["prefix"],
	objectName = __PARAMS["objectName"],
	type       = __PARAMS["type"],
	status     = __PARAMS["status"],
    priority   = __PARAMS["priority"],
    points     = __PARAMS["points"],
}

TICKET_GENERATOR:render()
