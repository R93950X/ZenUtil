if not ZenSilent then
    print("ZenFormat 0.01d By TheZen")
    
end

local digitsDefault = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}

function decimalToBase(decimalNumber, base, digits)
    -- Verify & Format Arguments
    if type(decimalNumber) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(decimalNumber), 2)
        
    elseif type(base) ~= "number" then
        error("Argument 2 - expected type: number, got "..type(base), 2)
        
    end
    
    digits = digits or {table.unpack(digitsDefault)}
    
    -- Function
    local newDigitCount = math.floor(math.log(decimalNumber) / math.log(base))
    local baseNumber = ""
    for i = newDigitCount, 0, -1 do
        baseNumber = baseNumber..digits[math.floor(decimalNumber / base ^ i) + 1]
        decimalNumber = decimalNumber % (base ^ i)
        
    end
    
    return baseNumber
    
end

function baseToDecimal(baseNumber, base, digits)
    -- Verify & Format Arguments
    if type(baseNumber) ~= "string" then
        error("Argument 1 - expected type: string, got "..type(baseNumber), 2)
        
    elseif type(base) ~= "number" then
        error("Argument 2 - expected type: number, got "..type(base), 2)
        
    end
    
    digits = digits or {table.unpack(digitsDefault)}
    for i, v in pairs(digits) do
        digits[v] = i - 1
        
    end
    
    -- Function
    local decimalNumber = 0
    for i = 1, #baseNumber do
        decimalNumber = decimalNumber + digits[string.sub(baseNumber, i, i)] * base ^ (#baseNumber - i)
        
    end
    
    return decimalNumber
    
end

function splitString(inputString, partScale)
    -- Verify & Format Arguments
    if type(inputString) ~= "string" then
        error("Argument 1 - expected type: string, got "..type(inputString), 2)
        
    elseif type(partScale) ~= "number" then
        error("Argument 2 - expected type: number, got "..type(partScale), 2)
        
    end
    
    -- Function
    local outputTable = {}
    repeat
        table.insert(outputTable, string.sub(inputString,1,partScale))
        inputString = string.sub(inputString,partScale+1,-1)
    until inputString == ""
    
    return outputTable
    
end

--[[
Todo:
    None!
]]