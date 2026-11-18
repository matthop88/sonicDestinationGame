local FILE_PATH      = "game/resources/images/spriteSheets/sonic1"
local DIRECTORY_UTIL = require("lib/util/directoryUtil")

local GRAFX          = love.graphics
local COLORS         = require("game/constants/colors")

local LIST_ITEM      = require("tools/transparencyEditor/lib/fileChooser/listItem")

return {
	fileList = nil,

	draw  = function(self)
		GRAFX.setColor(COLORS.JET_BLACK)
		GRAFX.rectangle("fill", 300, 100, 200, 400)
		GRAFX.setColor(COLORS.PURE_WHITE)
		GRAFX.rectangle("line", 300, 100, 200, 400)

		self:drawFileList()
	end,

	drawFileList = function(self)
		if self.fileList then
			for _, listItem in ipairs(self.fileList) do
				listItem:draw()
			end
		end
	end,

	update = function(self, dt)
		if self.fileList == nil then
			self:refreshFiles()
		end
	end,

	refreshFiles = function(self)
		local files = DIRECTORY_UTIL:getFilesInDirectory(FILE_PATH, ".png")
		self.fileList = {}
		local y = 120
		for _, filename in ipairs(files) do
			table.insert(self.fileList, LIST_ITEM:create { text = filename, x = 310, y = y, fontSize = 20 })
			y = y + 30
		end
	end,
	
}
