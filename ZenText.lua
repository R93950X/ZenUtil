if not ZenUtil.silent then
    print("ZenText 0.1 By TheZen")
    
end

local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

function writeAt(text,x,y)
    -- Verify & Format Arguments
    argumentCheck(text, "string", x, "number", y, "number")
    
    --Function
    local ox, oy = term.getCursorPos()
    for i = 0, select(2, text:gsub("\n","")) do
        local splitPoint = text:find("\n") or string.len(text)
        local line = text:sub(1,splitPoint-1)
        text = text:sub(splitPoint+1,-1)
        term.setCursorPos(x,y+i)
        term.write(line)
        
    end
    term.setCursorPos(ox,oy)
end

function printPlus(text)
    argumentCheck(text, "string")
    
    local termColor = term.getTextColor()
    repeat
        local splitPoint = string.find(text, "&") or string.len(text)+2
        local part = string.sub(text, 0, splitPoint-1)
        local Tcolor = tonumber(string.sub(text, splitPoint+1, splitPoint+1), 16)
        local Bcolor = tonumber(string.sub(text, splitPoint+2, splitPoint+2), 16)
        text = string.sub(text, splitPoint+3, -1)
        write(part)
        
        term.setTextColor(2^Tcolor)
        term.setTextColor(2^Bcolor)
        
    until text == ""
    term.setTextColor(termColor)
    term.setCursorPos(1, select(2, term.getCursorPos())+1)
    
    return true
    
end

--[[
Todo:
    None!
]]
