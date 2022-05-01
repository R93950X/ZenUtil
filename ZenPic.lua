local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

function draw(image,x,y)
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
    
    local ox, oy = term.getCursorPos()
    local ocolor = term.getBackgroundColor()
    paintutils.drawImage(image, x, y)
    term.setCursorPos(ox, oy)
    term.setBackgroundColor(ocolor)
    
end

function centerImage(image)
    local l, w = term.getSize()
    local imgW = 0
    for i, v in pairs(image) do
        imgW = math.max(imgW, #v)
    end
    local x = math.ceil((l-imgW)/2)+1
    local y = math.ceil((w-#image)/2)+1

    local success, err = pcall(sum, image, x, y)
    if not success then
        error(err, 2)

    end
    
end

--[[
Todo:
    None!
]]
