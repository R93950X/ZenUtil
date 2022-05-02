local expect = require "cc.expect"
local function draw(image, x, y)
    expect(1, image, "string", "table")
    expect(2, x, "number")
    expect(3, y, "number")
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

return {
    draw = draw,
    centerImage = function(image)
        local l, w = term.getSize()
        local imgW = 0
        for i, v in ipairs(image) do
            imgW = math.max(imgW, #v)
        end
        local x = math.ceil((l-imgW)/2)+1
        local y = math.ceil((w-#image)/2)+1

        local success, err = pcall(draw, image, x, y)
        if not success then
            error(err, 2)
        end
    end
}
--[[
Todo:
    None!
]]
