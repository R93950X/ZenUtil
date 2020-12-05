if not ZenSilent then
    print("ZenPic 0.01b By TheZen")
    
end

function draw(image,x,y)
    -- Verify & Format Arguments
    if type(image) ~= "string" and type(image) ~= "table" then
        error("Argument 1 - expected type: string, got "..type(image), 2)
        
    elseif type(x) ~= "number" and x ~= nil then
        error("Argument 2 - expected type: number, got "..type(x), 2)
        
    elseif type(y) ~= "number" and y ~= nil then
        error("Argument 3 - expected type: number, got "..type(y), 2)
        
    end
    
    if x == nil or y == nil then
        x, y = term.getCursorPos()
        
    end
    if type(image) == "string" then
        if not fs.find(image) then
            error("Argument 1 - file not found", 2)
            
        end
        image = paintutils.loadImage(image)
        
    end
    
    -- Function
    ox, oy = term.getCursorPos()
    ocolor = term.getBackgroundColor()
    paintutils.drawImage(image, x, y)
    term.setCursorPos(ox, oy)
    term.setBackgroundColor(ocolor)
    
end

function centerImage(image)
    -- Verify & Format Arguments
    if type(image) ~= "string" and type(image) ~= "table" then
        error("Argument 1 - expected type: string, got "..type(image), 2)
        
    end
    if type(image) == "string" then
        if not fs.find(image) then
            error("Argument 1 - file not found", 2)
            
        end
        
        image = paintutils.loadImage(image)
    end
    
    
    -- Function
    l, w = term.getSize()
    imgW = 0
    for i, v in pairs(image) do
        imgW = math.max(imgW, #v)
    end
    x = math.ceil((l-imgW)/2)+1
    y = math.ceil((w-#image)/2)+1
    draw(image,x,y)
    
end

--[[
Todo:
    None!
]]