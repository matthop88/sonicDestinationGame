return {
    create = function(self, params)
        return {
            drawingFn = params.drawingFn,

            draw      = function(self)
                if self.drawingFn then
                    self.drawingFn()
                end
            end,
            
        }
    end,
    
}
