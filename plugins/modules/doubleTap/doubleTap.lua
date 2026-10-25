--------------------------------------------------------------
--                     Double Tap Plugin                    --
--                         PLUG-0011                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Double Tap plugin provides automatic support for double-tapping on the keyboard. It has a latency threshold of 0.2 seconds.

                          Parameters
                          ----------
The Double Tap Plugin currently takes no parameters.
The application can directly make use of it via the registerListener() function, where the listener is a class with the function handleDoubleTapEvent(), which takes a key and a boolean (isDoubleTap) as parameters. The listener method is called any time a key press occurs.

The Double Tap Plugin is required by the Scrolling Plugin.

--]]


return {
    create = function(self, params)
        local THRESHOLD           = 0.2
        
        local lastKeypressed      = nil
        local lastKeypressedTime  = 0
        local lastThreshold       = 0

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
   
        return {
            listeners    = require("lib/util/smartList"):create {},

            registerListener = function(self, listener)
                if not self.listeners.contains(listener) then
                    table.insert(self.listeners, listener)
                end
            end,

            handleKeypressed = function(self, key)
                local isDblTap  = isDoubleTap(self, key)
                lastThreshold   = getThreshold(self)

                recordKey(self, key)

                for _, listener in ipairs(self.listeners) do
                    listener:handleDoubleTapEvent(key, isDblTap)
                end
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

    end,
}
