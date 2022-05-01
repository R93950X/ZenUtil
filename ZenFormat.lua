local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

local digitsDefault = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}

function decimalToBase(decimalNumber, base, digits)
    -- Verify & Format Arguments
    argumentCheck(decimalNumber, "number", base, "number")

    digits = type(digits) == "table" and digits or {table.unpack(digitsDefault)}
    
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
    argumentCheck(baseNumber, "string", base, "number")
    
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

--[[
Todo:
    None!
]]
