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

local __isDoubleTap  = function(self, key)
    return lastKeypressed == key and self:withinThreshold()
end

local __recordKey    = function(self, key)
    lastKeypressed     = key
    lastKeypressedTime = love.timer.getTime()
end

local __getThreshold = function(self)
    return love.timer.getTime() - lastKeypressedTime
end
   
--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    
    qualify      = function(self, key)
        local isDoubleTap  = __isDoubleTap(self, key)
        lastThreshold      = __getThreshold(self)

        __recordKey(self, key)
        return isDoubleTap
    end,

    withinThreshold = function(self)
        return __getThreshold(self) < THRESHOLD
    end,

    getLastKeypressed = function(self)
        return lastKeypressed
    end,

    getLastThreshold  = function(self)
        return lastThreshold
    end,

}
