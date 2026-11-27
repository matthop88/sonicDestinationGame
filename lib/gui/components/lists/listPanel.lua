local GRAFX          = love.graphics
local MOUSE          = love.mouse

local COLORS         = require("game/constants/colors")
local LIST_ITEM      = require("lib/gui/components/lists/listItem")

return {
    create = function(self, params)
        local FONT      = GRAFX.newFont(20)
            
        return {
            x              = params.x,
            y              = params.y,
            w              = params.w,
            h              = params.h,
            rawList        = params.list,
            onItemSelected = params.onSelected,

            draw  = function(self)
                self:drawPanel()
                self:drawList()
            end,

            drawPanel = function(self)
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h)
                GRAFX.setColor(COLORS.MEDIUM_GREY)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h)
            end,

            drawList = function(self)
                if self.list then
                    for _, listItem in ipairs(self.list) do
                        listItem:draw()
                    end
                end
            end,

            update = function(self, dt)
                local mx, my = MOUSE.getPosition()

                if self.list == nil then 
                    self:refreshList()
                else
                    for _, listItem in ipairs(self.list) do listItem:update(dt, mx, my) end
                end
            end,

            refreshList = function(self)
                self.list = {}
                local y = self.y
                for _, name in ipairs(self.rawList) do
                    table.insert(self.list, LIST_ITEM:create { text = name, x = self.x, y = y, w = self.w, fontSize = 20 })
                    y = y + 27
                end
            end,

            setList = function(self, list)
                self.rawList = list
                self.list    = nil
            end,

            handleMousepressed = function(self, mx, my)
                if self.list and self:mouseInBounds(mx, my) then
                    for _, listItem in ipairs(self.list) do
                        if listItem:handleMousepressed(mx, my) then
                            self.onItemSelected(listItem.text)
                        end
                    end

                    return true
                end
            end,

            handleKeypressed = function(self, key)
                -- do nothing
            end,

            mouseInBounds = function(self, mx, my)
                return mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h
            end,

        }
    end,

}
