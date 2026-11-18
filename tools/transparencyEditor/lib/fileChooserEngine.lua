local FILE_PATH = "game/resources/images/spriteSheets/sonic1"
local DIRECTORY_UTIL = require("lib/util/directoryUtil")

local GRAFX     = love.graphics
local COLORS    = require("game/constants/colors")
local FONT      = GRAFX.newFont(20)

return {
	files = nil,

	draw  = function(self)
		GRAFX.setColor(COLORS.JET_BLACK)
		GRAFX.rectangle("fill", 300, 100, 200, 400)
		GRAFX.setColor(COLORS.PURE_WHITE)
		GRAFX.rectangle("line", 300, 100, 200, 400)

		self:drawFileList()
	end,

	drawFileList = function(self)
		local y = 120
		if self.files then
			GRAFX.setColor(COLORS.PURE_WHITE)
			GRAFX.setFont(FONT)
			for _, filename in ipairs(self.files) do
				GRAFX.printf(filename, 310, y, 200, "left")
				y = y + 30
			end
		end
	end,

	update = function(self, dt)
		if self.files == nil then
			self:refreshFiles()
		end
	end,

	refreshFiles = function(self)
		self.files = DIRECTORY_UTIL:getFilesInDirectory(FILE_PATH, ".png")
	end,
	
}
