local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")
local ternary        = require("lib/util/ternary")
	
local TICKET_GENERATOR = ({
	
	ELLIPSES = [[
    ...
    ...
    ...]],

	init = function(self, params)
		self.params = params

		self:generateID()
		self:generateDate()
		self:generateTitle()
		self:generateVersion()
		self:generateSummary()
		self:generateDetails()
		self:generateAcceptanceCriteria()
		self:generateNotes()
		self:generateParameters()
		self:generateHistory()

		return self
	end,

	generateID = function(self)
		self.params.id = string.upper(TICKET_ID_UTIL:getNextID(self.params.prefix))
	end,

	generateDate = function(self)
		self.date = os.date("%Y-%m-%d")
		self.params.createdAt = self.date
		self.params.updatedAt = self.date
	end,

	generateTitle = function(self)
		self.params.title = ternary { IF   = TICKET_ID_UTIL:findObjectName(self.params.objectName),
						   			  THEN = "Upgrade ",
						   			  ELSE = "Implement " } .. self.params.objectName
	end,

	generateVersion = function(self)
		self.params.version = "0.1"
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
		self.params.parameters = [[
* parameter1 - description
* parameter2 - description
* parameter3 - description]]
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

		love.system.setClipboardText(template:render(self.params))

		print("Ticket template saved to clipboard (id = " .. self.params.id .. ")")
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
