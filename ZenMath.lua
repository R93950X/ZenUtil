local expect = require "cc.expect"

local function gcd(x, y)
    expect(1, x, "number")
    expect(2, y, "number")
    return y == 0 and x or gcd(y, x % y)
end

local function sum(...)
    local x = {...}
    for i, v in ipairs(x) do
        if type(v) ~= "number" then
            error("Argument "..i.." - expected type: number, got "..type(v), 2)
        end
    end
    
    local val = 0
    for i, v in pairs(x) do
        val = val + v
    end
    return val
end

local function asinh(x)
    expect(1, x, "number")
    return math.log(x + (x*x + 1)^0.5)
end

local function acosh(x)
    expect(1, x, "number")
    return math.log(x + (x*x - 1)^0.5)
end

local function atanh(x)
    expect(1, x, "number")
    return math.log((1 + x)/(1 - x))/2
end

return {
    root = function(x, n)
        expect(1, x, "number")
        expect(2, n, "number")
        return x ^ (1 / n)
    end,
    log = function(x, b)
        expect(1, x, "number")
        expect(2, b, "number")
        return math.log(x)/math.log(b)
    end,
    gcd = gcd,
    lcm = function(x, y)
        expect(1, x, "number")
        expect(2, y, "number")
        return x * y / gcd(x, y)
    end,
    areaOfCircle = function(r)
        expect(1, r, "number")
        return math.pi * r * r
    end,
    circumferenceOfCircle = function(r)
        expect(1, r, "number")
        return math.pi * r * 2
    end,
    sum = sum,
    mean = function(...)
        local success, sumVal = pcall(sum, ...)
        if success then
            return sumVal/#{...}
        else
            error(sumVal, 2)
        end
    end,
    mode = function(...)
        local x = {...}
        for i, v in ipairs(x) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
            end
        end
        
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
        for i, v in ipairs(x) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
            end
        end
        
        table.sort(x)
        return #x % 2 == 0 and (x[#x/2] + x[#x/2 + 1])/2 or (x[#x/2 + 0.5])
    end,
    sec = function(x)
        expect(1, x, "number")
        return 1/math.cos(x)
    end,
    csc = function(x)
        expect(1, x, "number")
        return 1/math.sin(x)
    end,
    cot = function(x)
        expect(1, x, "number")
        return 1/math.tan(x)
    end,
    asec = function(x)
        expect(1, x, "number")
        return math.acos(1/x)
    end,
    acsc = function(x)
        expect(1, x, "number")
        return math.asin(1/x)
    end,
    acot = function(x)
        expect(1, x, "number")
        return math.atan(1/x)
    end,
    sech = function(x)
        expect(1, x, "number")
        return 1/math.cosh(x)
    end,
    csch = function(x)
        expect(1, x, "number")
        return 1/math.sinh(x)
    end,
    coth = function(x)
        expect(1, x, "number")
        return 1/math.tanh(x)
    end,
    asinh = asinh,
    acosh = acosh,
    atanh = atanh,
    acsch = function(x)
        expect(1, x, "number")
        return asinh(1/x)
    end,
    asech = function(x)
        expect(1, x, "number")
        return acosh(1/x)
    end,
    acoth = function(x)
        expect(1, x, "number")
        return atanh(1/x)
    end
}
--[[
Todo:
    - New (better) RNG ?

    - Matrices
    - Moar vectors (higher-d)
    - Complex Numbers
    - Ratio type (fraction)
]]
