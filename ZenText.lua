local expect = require "cc.expect"
return {
    writeAt = function(text, x, y)
        expect(1, text, "string")
        expect(2, x, "number")
        expect(3, y, "number")
        
        local ox, oy = term.getCursorPos()
        for i = 0, select(2, text:gsub("\n","")) do
            local splitPoint = text:find("\n") or string.len(text)+1
            local line = text:sub(1,splitPoint-1)
            text = text:sub(splitPoint+1,-1)
            term.setCursorPos(x,y+i)
            term.write(line)
        end
        term.setCursorPos(ox,oy)
    end,
    printPlus = function(text)
        expect(1, text, "string")
        
        local termColor = term.getTextColor()
        repeat
            local splitPoint = string.find(text, "&") or string.len(text)+2
            local part = string.sub(text, 0, splitPoint-1)
            local Tcolor = tonumber(string.sub(text, splitPoint+1, splitPoint+1), 16) or 16
            local Bcolor = tonumber(string.sub(text, splitPoint+2, splitPoint+2), 16) or 0
            text = string.sub(text, splitPoint+3, -1)
            write(part)
            
            term.setTextColor(2^Tcolor)
            term.setTextColor(2^Bcolor)
            
        until text == ""
        term.setTextColor(termColor)
        term.setCursorPos(1, select(2, term.getCursorPos())+1)
        return true
    end
}
--[[
Todo:
    utilize term.blit() in printPlus
]]
