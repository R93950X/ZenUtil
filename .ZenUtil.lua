local digitsDefault = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}
local function gcd(x, y)
    return y == 0 and x or gcd(y, x % y)
end
local function sum(...)
    local x = {...}
    
    local val = 0
    for i, v in pairs(x) do
        val = val + v
    end
    return val
end
local function asinh(x)
    return math.log(x + (x*x + 1)^0.5)
end
local function acosh(x)
    return math.log(x + (x*x - 1)^0.5)
end
local function atanh(x)
    return math.log((1 + x)/(1 - x))/2
end
local function draw(image, x, y)
    if x == nil or y == nil then
        x, y = term.getCursorPos()
    end
    
    local ox, oy = term.getCursorPos()
    local ocolor = term.getBackgroundColor()
    paintutils.drawImage(image, x, y)
    term.setCursorPos(ox, oy)
    term.setBackgroundColor(ocolor)
end
return {
    ZenFormat = {
        decimalToBase = function(decimalNumber, base, digits)
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
            digits = digits or {table.unpack(digitsDefault)}
            for i, v in ipairs(digits) do
                digits[v] = i - 1
            end
            
            local decimalNumber = 0
            for i = 1, #baseNumber do
                decimalNumber = decimalNumber + digits[string.sub(baseNumber, i, i)] * base ^ (#baseNumber - i)
                
            end
            return decimalNumber
        end
    },
    ZenMath =  {
        root = function(x, n)
            return x ^ (1 / n)
        end,
        log = function(x, b)
            return math.log(x)/math.log(b)
        end,
        gcd = gcd,
        lcm = function(x, y)
            return x * y / gcd(x, y)
        end,
        areaOfCircle = function(r)
            return math.pi * r * r
        end,
        circumferenceOfCircle = function(r)
            return math.pi * r * 2
        end,
        sum = sum,
        mean = function(...)
            return sum(...)/#{...}
        end,
        mode = function(...)
            local x = {...}
            
            local Counts = {}
            for i, v in pairs(x) do
                Counts[v] = Counts[v] and Counts[v] + 1 or 1
            end
            local greatestCount = 0
            for i, v in pairs(Counts) do
                greatestCount = v > greatestCount and v or greatestCount
            end
            local mode = {}
            for i, v in pairs(Counts) do
                if v == greatestCount then
                    table.insert(mode, i)
                end
            end
            return mode
        end,
        median = function(...)
            local x = {...}
            
            table.sort(x)
            return #x % 2 == 0 and (x[#x/2] + x[#x/2 + 1])/2 or (x[#x/2 + 0.5])
        end,
        sec = function(x)
            return 1/math.cos(x)
        end,
        csc = function(x)
            return 1/math.sin(x)
        end,
        cot = function(x)
            return 1/math.tan(x)
        end,
        asec = function(x)
            return math.acos(1/x)
        end,
        acsc = function(x)
            return math.asin(1/x)
        end,
        acot = function(x)
            return math.atan(1/x)
        end,
        sech = function(x)
            return 1/math.cosh(x)
        end,
        csch = function(x)
            return 1/math.sinh(x)
        end,
        coth = function(x)
            return 1/math.tanh(x)
        end,
        asinh = asinh,
        acosh = acosh,
        atanh = atanh,
        acsch = function(x)
            return asinh(1/x)
        end,
        asech = function(x)
            return acosh(1/x)
        end,
        acoth = function(x)
            return atanh(1/x)
        end
    },
    ZenPic = {
        draw = draw,
        centerImage = function(image)
            local l, w = term.getSize()
            local imgW = 0
            for i, v in ipairs(image) do
                imgW = math.max(imgW, #v)
            end
            local x = math.ceil((l-imgW)/2)+1
            local y = math.ceil((w-#image)/2)+1

            draw(image, x, y)
        end
    },
    ZenTable = {
        shuffle = function(tbl)
            for i = #tbl, 2, -1 do
                local j = math.random(i)
                tbl[i], tbl[j] = tbl[j], tbl[i]
            end
        end,
        reverse = function(tbl)
            local pos1 = 1
            local pos2 = #tbl
            while pos1 < pos2 do
                tbl[pos1], tbl[pos2] = tbl[pos2], tbl[pos1]
                pos1 = pos1 + 1
                pos2 = pos2 - 1
            end
        end,
        deepCopy = function(tbl)
            local clone = {}
            for k, v in ipairs(tbl) do
                if type(v) == "table" then
                    clone[k] = deepCopy(v)
                else
                    clone[k] = v
                end
            end
            return clone
        end
    },
    ZenText = {
        writeAt = function(text, x, y)
            local ox, oy = term.getCursorPos()
            for i = 0, select(2, text:gsub("\n","")) do
                local splitPoint = text:find("\n") or string.len(text)
                local line = text:sub(1,splitPoint-1)
                text = text:sub(splitPoint+1,-1)
                term.setCursorPos(x,y+i)
                term.write(line)
            end
            term.setCursorPos(ox,oy)
        end,
        printPlus = function(text)
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
    }
}