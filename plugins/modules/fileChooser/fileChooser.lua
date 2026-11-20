--------------------------------------------------------------
--                    File Chooser Plugin                   --
--                        Version 0.1                       --
--                         PLUG-0034                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The File Chooser Plugin displays a dialog on the screen
where a file can be selected.
When the file is selected, a callback is called and the dialog
goes away.

                          Parameters
                          ----------
* x              - x coordinate of dialog box (default: 300)
* y              - y coordinate of dialog box (default: 100)
* w              - width  of dialog box       (default: 200)
* h              - height of dialog box       (default: 400)
* filePath       - path of directory where files can be found
* onFileSelected - object to call back, with method onFileSelected()
* visible        - whether dialog box is initially visible. Defaults to false.

--]]

local DIRECTORY_UTIL = require("lib/util/directoryUtil")

local GRAFX          = love.graphics
local MOUSE          = love.mouse

local COLORS         = require("game/constants/colors")
local LIST_ITEM      = require("plugins/modules/fileChooser/listItem")

return {
    create = function(self, params)
        
        local FILE_PATH = params.filePath

        return {
            x = params.x or 300,
            y = params.y or 100,
            w = params.w or 200,
            h = params.h or 400,

            onFileSelectedObj = params.onFileSelected,

            imageBuffer       = GRAFX.newCanvas(params.w or 200, params.h or 400),

            fileList          = nil,
            visible           = params.visible,

            draw  = function(self)
                if self.visible then
                    GRAFX.setCanvas(self.imageBuffer)
                    self:drawPanel()
                    self:drawCaption()
                    self:drawFileList()
                    GRAFX.setCanvas()
                    self:drawBufferedImage()
                end
            end,

            drawPanel = function(self)
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", 0, 0, self.w, self.h)
                GRAFX.setColor(COLORS.PURE_WHITE)
                GRAFX.rectangle("line", 0, 0, self.w, self.h)
            end,

            drawCaption = function(self)
                GRAFX.setColor(COLORS.BURNT_ORANGE)
                GRAFX.rectangle("fill", 0, 0, self.w, 30)
                GRAFX.setColor(COLORS.JET_BLACK)
                GRAFX.printf("Please Select a File", 0, 3, self.w, "center")
                GRAFX.rectangle("line", 0, 0, self.w, 30)
            end,

            drawFileList = function(self)
                if self.fileList then
                    for _, listItem in ipairs(self.fileList) do
                        listItem:draw()
                    end
                end
            end,

            drawBufferedImage = function(self)
                GRAFX.setColor(COLORS.PURE_WHITE)
                GRAFX.draw(self.imageBuffer, self.x, self.y)
            end,

            update = function(self, dt)
                local mx, my = MOUSE.getPosition()

                if self.visible then
                    if self.fileList == nil then 
                        self:refreshFiles()
                    else
                        for _, listItem in ipairs(self.fileList) do listItem:update(dt, mx - self.x, my - self.y) end
                    end
                end
            end,

            refreshFiles = function(self)
                local files = DIRECTORY_UTIL:getFilesInDirectory(FILE_PATH, ".png")
                self.fileList = {}
                local y = 50
                for _, filename in ipairs(files) do
                    table.insert(self.fileList, LIST_ITEM:create { text = filename, x = 0, y = y, w = self.w, fontSize = 20 })
                    y = y + 27
                end
            end,

            handleMousepressed = function(self, mx, my)
                if self.visible then
                    if mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h then
                        for _, listItem in ipairs(self.fileList) do
                            if listItem:handleMousepressed(mx - self.x, my - self.y) then
                                self.onFileSelectedObj:onFileSelected(listItem.text)
                            end
                        end
                    end

                    return true
                end
            end,

            handleKeypressed = function(self, key)
                if self.visible then
                    if key == "escape" then
                        self.onFileSelectedObj:onFileSelected("")
                    end
                    return true
                end
            end,

            show = function(self)
                self.visible = true
            end,

            hide = function(self)
                self.visible = false
                self.fileList = nil
            end,

        }
    end,

}
