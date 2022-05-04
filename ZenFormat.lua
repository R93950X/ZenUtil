local expect = require "cc.expect"
local digitsDefault = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}
return {
    decimalToBase = function(decimalNumber, base, digits)
        expect(1, decimalNumber, "number")
        expect(2, base, "number")
        expect(3, digits, "table", "nil")
        digits = type(digits) == "table" and digits or {table.unpack(digitsDefault)}

        local newDigitCount = math.floor(math.log(decimalNumber) / math.log(base))
        local baseNumber = ""
        for i = newDigitCount, 0, -1 do
            baseNumber = baseNumber..digits[math.floor(decimalNumber / base ^ i) + 1]
            decimalNumber = decimalNumber % (base ^ i)
        end
        return baseNumber
    end,
    baseToDecimal = function(baseNumber, base, digits)
        expect(1, baseNumber, "number", "string")
        expect(2, base, "number")
        expect(3, digits, "table", "nil")
        digits = digits or {table.unpack(digitsDefault)}
        for i, v in ipairs(digits) do
            digits[v] = i - 1
        end
        
        local decimalNumber = 0
        for i = 1, string.len(baseNumber) do
            decimalNumber = decimalNumber + digits[string.sub(baseNumber, i, i)] * base ^ (string.len(baseNumber) - i)
            
        end
        return decimalNumber
    end
}
--[[
Todo:
    None!
]]
