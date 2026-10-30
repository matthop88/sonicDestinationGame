--------------------------------------------------------------
--                       Custom Plugin                      --
--                         PLUG-0017                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Custom Plugin allows an object that is not part of the plugin repository to
function as a plugin. This object is expected to implement the draw(), update(),
handleMousepressed(), handleKeypressed(), etc. methods as needed.
Like plugins, it will be executed automatically without requiring a reference.

                          Parameters
                          ----------
* object - the name of the local object that will be acting as a plugin
* all other parameters required by the object

--]]

return {
    create = function(self, params)
        return params.object:create(params)
    end,
}
