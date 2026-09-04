--------------------------------------------------------------
--                       Private Members                    --
--------------------------------------------------------------

local THRESHOLD           = 0.2

local lastKeypressed      = nil
local lastKeypressedTime  = 0
local lastThreshold       = 0
   
return {
    ------------------------- Public Methods -------------------------

    qualify      = function(self, key)
        local isDoubleTap  = self:isDoubleTap(key)
        lastThreshold      = self:getThreshold()

        self:recordKey(key)
        return isDoubleTap
    end,

    withinThreshold = function(self)
        return self:getThreshold() < THRESHOLD
    end,

    getLastKeypressed = function(self)
        return lastKeypressed
    end,

    getLastThreshold  = function(self)
        return lastThreshold
    end,

    ------------------------- Private Methods ------------------------


    isDoubleTap  = function(self, key)
        return lastKeypressed == key and self:withinThreshold()
    end,

    recordKey    = function(self, key)
        lastKeypressed     = key
        lastKeypressedTime = love.timer.getTime()
    end,

    getThreshold = function(self)
        return love.timer.getTime() - lastKeypressedTime
    end,

}
