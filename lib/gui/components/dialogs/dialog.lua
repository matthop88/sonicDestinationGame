local GRAFX          = love.graphics
local MOUSE          = love.mouse

local COLORS         = require("game/constants/colors")

return {
    create = function(self, params)
        return ({
            x       = params.x       or 300,
            y       = params.y       or 100,
            w       = params.w       or 200,
            h       = params.h       or 400,
            caption = params.caption or "Untitled Dialog",
            visible = params.visible,

            FONT    = GRAFX.newFont(20),
                
        	init    = function(self, params)
                self.okButton = require("lib/gui/components/buttons/button"):create {
                    text = params.okText or "OK",
                    x    = self.x + self.w - 120,
                    y    = self.y + self.h -  50,
                    w    = 100,
                }
                self.cancelButton = require("lib/gui/components/buttons/button"):create {
                    text  = params.cancelText      or "Cancel",
                    x     = self.x + self.w - 230,
                    y     = self.y + self.h -  50,
                    w     = 100,
                    color = COLORS.MEDIUM_GREY,
                }
                self.components = params.components

                self.componentList = {}
                for k, v in pairs(self.components) do
                    table.insert(self.componentList, v)
                end

        		return self
        	end,

            draw = function(self)
                if self.visible then
                    self:drawPanel()
                    self:drawCaption()
                    self:drawButtons()
                    self:drawComponents()
                end
            end,

            drawPanel = function(self)         
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.setLineWidth(1)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h, 20, 20)
            end,

            drawCaption = function(self)
                GRAFX.setColor(COLORS.BURNT_ORANGE)
                GRAFX.rectangle("fill", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.JET_BLACK)
                GRAFX.setFont(self.FONT)
                GRAFX.printf(self.caption, self.x, self.y + 3, self.w, "center")
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.setLineWidth(1)
                GRAFX.rectangle("line", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x + 1, self.y + 30, self.w - 2, 16)
            end,

            drawButtons = function(self)
                self.cancelButton:draw()
                self.okButton:draw()
            end,

            drawComponents = function(self)
                for _, component in ipairs(self.componentList) do
                    component:draw()
                end
            end,

            getComponent = function(self, name)
                return self.components[name]
            end,

            update = function(self, dt)
                self.cancelButton:update(dt)
                self.okButton:update(dt)
                for _, component in ipairs(self.componentList) do
                    component:update(dt)
                end
            end,
            
            handleKeypressed = function(self, key)
                if self.visible then
                    if key == "escape" then
                        self:hide()
                    else
                        for _, component in ipairs(self.componentList) do
                            component:handleKeypressed(key)
                        end
                    end
                    return true
                end
            end,

            handleMousepressed = function(self, mx, my)
                if self.visible and self:mouseInBounds(mx, my) then
                    self.okButton:handleMousepressed(mx, my)
                    self.cancelButton:handleMousepressed(mx, my)
                    for _, component in ipairs(self.componentList) do
                        component:handleMousepressed(mx, my)
                    end
                    return true
                end
            end,

            handleMousereleased = function(self, mx, my)
                if self.visible and self:mouseInBounds(mx, my) then
                    if self.okButton:handleMousereleased(mx, my) then
                        self:okButtonClicked()
                    elseif self.cancelButton:handleMousereleased(mx, my) then
                        self:cancelButtonClicked()
                    end
                    return true
                end
            end,

            okButtonClicked = function(self)
                print("OK Button Clicked")
                self.visible = false
            end,

            cancelButtonClicked = function(self)
                print("Cancel Button Clicked")
                self.visible = false
            end,

            mouseInBounds = function(self, mx, my)
                return mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h
            end,

            show = function(self)
                self.visible = true
            end,

            hide = function(self)
                self.visible = false
            end,

        }):init(params)

    end,
}
