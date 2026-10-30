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
    local x, y = imageView:imageToScreenCoordinates(self.x - 1, self.y - 1)

    local scale = imageView:getScale()
    love.graphics.setColor { 1, 1, 0 }
    love.graphics.setLineWidth(scale * 3)

    love.graphics.rectangle("line", x, y, (self.w + 2) * scale, (self.h + 2) * scale)
    if love.mouse.isDown(1) then
        love.graphics.setColor { 1, 1, 1, 0.4 }
        love.graphics.rectangle("fill", x, y, self.w * scale, self.h * scale)
    end
end

local drawRect = function(self, imageView)
    if self.isHighlighted then drawHighlightedRect(self, imageView)
    else                       drawUnhighlightedRect(self, imageView) end
end

local isRectAdjacentTo = function(self, x, y, w, vGapTolerance, wVarianceTolerance)
    return math.abs(y - (self.y + self.h)) < (vGapTolerance + 1) and x + w > self.x and math.abs(x + w - self.x - self.w) < wVarianceTolerance
end

local appendLineToRect = function(self, x, y, w)
    self.h = y - self.y + 1
    self.w = math.max(w, self.w)
end

local SPRITE_RECT = {
    create = function(self, x, y, w, h)
        return {
            x = x,
            y = y,
            w = w,
            h = h,

            isHighlighted = false,

            contains      = ptInRect,

            draw          = drawRect,
            update        = updateRect,

            isAdjacentTo  = isRectAdjacentTo,
            appendLine    = appendLineToRect,
        }
        
    end,

}

return {
    create = function(self, params)
        local VERTICAL_GAP_TOLERANCE   = params.verticalGapTolerance or 1
        local WIDTH_VARIANCE_TOLERANCE = params.widthVarianceTolerance or 0

        return {
            imageView = params.imageView,

            addLine   = function(self, x, y, w)
                local adjacentRect = self:getAdjacentRect(x, y, w)
                if adjacentRect then adjacentRect:appendLine(x, y, w)
                else                 self:add(x, y, w, 1)      end
            end,

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

            getAdjacentRect = function(self, x, y, w)
                for _, spriteRect in ipairs(self) do
                    if spriteRect:isAdjacentTo(x, y, w, VERTICAL_GAP_TOLERANCE, WIDTH_VARIANCE_TOLERANCE) then
                        return spriteRect
                    end
                end
            end,

        }

    end,

}
