return {
    THRESHOLD          = 0.2,

    lastKeypressed     = nil,
    lastKeypressedTime = 0,
    lastThreshold      = 0,

    qualify      = function(self, key)
        local isDoubleTap  = self:isDoubleTap(key)
        self.lastThreshold = self:getThreshold()

        self:recordKey(key)
        return isDoubleTap
    end,

    isDoubleTap  = function(self, key)
        return self.lastKeypressed == key and self:withinThreshold()
    end,

    withinThreshold = function(self)
        return self:getThreshold() < self.THRESHOLD
    end,

    recordKey    = function(self, key)
        self.lastKeypressed     = key
        self.lastKeypressedTime = love.timer.getTime()
    end,

    getThreshold = function(self)
        return love.timer.getTime() - self.lastKeypressedTime
    end,

    getLastKeypressed = function(self)
        return self.lastKeypressed
    end,

    getLastThreshold  = function(self)
        return self.lastThreshold
    end,
}
