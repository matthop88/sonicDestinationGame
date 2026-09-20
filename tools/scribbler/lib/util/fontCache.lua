local GRAFX = love.graphics

return {
	FONTS = {},

	getFont = function(self, fontSize)
		local font = self.FONTS[fontSize]

		if font == nil then
			font = GRAFX.newFont(fontSize)
			self.FONTS[fontSize] = font
		end

		return font
	end,

}
