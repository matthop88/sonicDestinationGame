local ptInRect = function(self, px, py)
    return px > self.x and px < self.x + self.w and py > self.y and py < self.y + self.h
end

local updateRect = function(self, mx, my)
    self.isHighlighted = self:contains(mx, my)
end

local drawUnhighlightedRect = function(self, imageView)
    local x, y = imageView:imageToScreenCoordinates(self.x, self.y)

    local scale = imageView:getScale()
    love.graphics.setColor { 1, 1, 1 }
    love.graphics.setLineWidth(scale)

    love.graphics.rectangle("line", x, y, self.w * scale, self.h * scale)
end

local drawHighlightedRect = function(self, imageView)
    local x, y = imageView:imageToScreenCoordinates(self.x, self.y)

    local scale = imageView:getScale()
    love.graphics.setColor { 1, 1, 0 }
    love.graphics.setLineWidth(scale * 3)

    love.graphics.rectangle("line", x, y, self.w * scale, self.h * scale)
    if love.mouse.isDown(1) then
        love.graphics.setColor { 1, 1, 1, 0.4 }
        love.graphics.rectangle("fill", x, y, self.w * scale, self.h * scale)
    end
end

local drawRect = function(self, imageView)
    if self.isHighlighted then drawHighlightedRect(self, imageView)
    else                       drawUnhighlightedRect(self, imageView) end
end

local SPRITE_RECT = {
    create = function(self, x, y, w, h)
        return {
            x = x,
            y = y,
            w = w,
            h = h,

            isHighlighted = false,

            contains = ptInRect,

            draw     = drawRect,
            update   = updateRect,

        }
        
    end,

}

return {
    create = function(self, imageView)
        return {
            imageView = imageView,

            add       = function(self, x, y, w, h)
                table.insert(self, SPRITE_RECT:create(x, y, w, h))
                return self
            end,

            draw      = function(self)
                for _, spriteRect in ipairs(self) do
                    spriteRect:draw(self.imageView)
                end
            end,
    
            update    = function(self, dt)
                local imageX, imageY = self.imageView:screenToImageCoordinates(love.mouse.getPosition())

                for _, spriteRect in ipairs(self) do
                    spriteRect:update(imageX, imageY)
                end
            end,

            getHighlighted = function(self)
                for _, spriteRect in ipairs(self) do
                    if spriteRect.isHighlighted then
                        return spriteRect
                    end
                end
            end,

        }

    end,

}
