--------------------------------------------------------------
--                       Private Members                    --
--------------------------------------------------------------

local THRESHOLD           = 0.2

local lastKeypressed      = nil
local lastKeypressedTime  = 0
local lastThreshold       = 0

--------------------------------------------------------------
--                       Private Methods                    --
--------------------------------------------------------------

local isDoubleTap  = function(self, key)
    return lastKeypressed == key and self:withinThreshold()
end

local recordKey    = function(self, key)
    lastKeypressed     = key
    lastKeypressedTime = love.timer.getTime()
end

local getThreshold = function(self)
    return love.timer.getTime() - lastKeypressedTime
end
   
--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    
    qualify      = function(self, key)
        local isDoubleTap  = isDoubleTap(self, key)
        lastThreshold      = getThreshold(self)

        recordKey(self, key)
        return isDoubleTap
    end,

    withinThreshold = function(self)
        return getThreshold(self) < THRESHOLD
    end,

    getLastKeypressed = function(self)
        return lastKeypressed
    end,

    getLastThreshold  = function(self)
        return lastThreshold
    end,

}
