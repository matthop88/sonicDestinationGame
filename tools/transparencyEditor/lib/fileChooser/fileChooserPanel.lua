local DIRECTORY_UTIL = require("lib/util/directoryUtil")

local GRAFX          = love.graphics
local COLORS         = require("game/constants/colors")

local LIST_ITEM      = require("tools/transparencyEditor/lib/fileChooser/listItem")

return {
	create = function(self, params)
		local FILE_PATH = params.filePath

		return {
			x = params.x or 300,
			y = params.y or 100,
			w = params.w or 200,
			h = params.h or 400,

			onFileSelectedObj = params.onFileSelected,

			fileList = nil,
			visible  = params.visible,

			draw  = function(self)
				if self.visible then
					self:drawPanel()
					self:drawCaption()
					self:drawFileList()
				end
			end,

			drawPanel = function(self)
				GRAFX.setColor(COLORS.JET_BLACK)
				GRAFX.rectangle("fill", self.x, self.y, self.w, self.h)
				GRAFX.setColor(COLORS.PURE_WHITE)
				GRAFX.rectangle("line", self.x, self.y, self.w, self.h)
			end,

			drawCaption = function(self)
				GRAFX.setColor(COLORS.DARK_GREY)
				GRAFX.rectangle("fill", self.x, self.y, self.w, 30)
				GRAFX.setColor(COLORS.LIGHT_GREY)
				GRAFX.printf("Please Select a File", self.x, self.y + 3, self.w, "center")
				GRAFX.rectangle("line", self.x, self.y, self.w, 30)
			end,

			drawFileList = function(self)
				if self.fileList then
					for _, listItem in ipairs(self.fileList) do
						listItem:draw()
					end
				end
			end,

			update = function(self, dt)
				if self.visible then
					if self.fileList == nil then 
						self:refreshFiles()
					else
						for _, listItem in ipairs(self.fileList) do listItem:update(dt) end
					end
				end
			end,

			refreshFiles = function(self)
				local files = DIRECTORY_UTIL:getFilesInDirectory(FILE_PATH, ".png")
				self.fileList = {}
				local y = self.y + 50
				for _, filename in ipairs(files) do
					table.insert(self.fileList, LIST_ITEM:create { text = filename, x = self.x, y = y, w = self.w, fontSize = 20 })
					y = y + 27
				end
			end,

			handleMousepressed = function(self, mx, my)
				if self.visible then
					if mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h then
						for _, listItem in ipairs(self.fileList) do
							if listItem:handleMousepressed(mx, my) then
								self.onFileSelectedObj:onFileSelected(listItem.text)
							end
						end
					end

					return true
				end
			end,

			handleKeypressed = function(self, key)
				if self.visible then
					if key == "escape" then
						self.onFileSelectedObj:onFileSelected("")
					end
					return true
				end
			end,

			show = function(self)
				self.visible = true
			end,

			hide = function(self)
				self.visible = false
				self.fileList = nil
			end,

		}
	end,
	
}
