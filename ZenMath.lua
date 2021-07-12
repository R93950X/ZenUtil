if not ZenUtil.silent then
    print("ZenMath 0.3 By TheZen")
    
end 

local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

do -- General Functions
    function root(x, n)
        argumentCheck(x, "number", root, "number")

        return x ^ (1 / n)
        
    end

    function log(x, b)
        argumentCheck(x, "number", b, "number")

        return math.log(x)/math.log(b)

    end

    function gcd(x, y)
        argumentCheck(x, "number", y, "number")

        return y == 0 and x or gcd(y, x % y)

    end

    function lcm(x, y)
        argumentCheck(x, "number", y, "number")

        return x * y / gcd(x, y)
    end

end

do -- Circle Functions
    function areaOfCircle(r)
        -- Verify & Format Arguments
        argumentCheck(r, "number")
        
        -- Function
        return math.pi * r * r
        
    end

    function circumferenceOfCircle(r)
        -- Verify & Format Arguments
        argumentCheck(r, "number")
        
        -- Function
        return math.pi * r * 2
        
    end

end

do -- Statistics Functions
    function sum(...)
        local x = {...}
        
        for i, v in pairs(x) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        local sum = 0
        for i, v in pairs(x) do
            sum = sum + v
        end
        
        return sum
        
    end

    function mean(...)
        local success, sumVal = pcall(sum, ...)
        if success then
            return sumVal/#{...}
            
        else
            error(sumVal, 2)

        end
        
    end

    function mode(...)
        local x = {...}
        
        for i, v in pairs(x) do
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
        
    end

    function median(...)
        local x = {...}
        
        for i, v in pairs(x) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        table.sort(x)
        
        return #x % 2 == 0 and (x[#x/2] + x[#x/2 + 1])/2 or (x[#x/2 + 0.5])
        
    end
end

do -- Trigonometry Functions
    function sec(x)
        argumentCheck(x, "number")
        return 1/math.cos(x)
        
    end

    function csc(x)
        argumentCheck(x, "number")
        return 1/math.sin(x)
        
    end

    function cot(x)
        argumentCheck(x, "number")
        return 1/math.tan(x)
        
    end

    function asec(x)
        argumentCheck(x, "number")
        return math.acos(1/x)
        
    end

    function acsc(x)
        argumentCheck(x, "number")
        return math.asin(1/x)
        
    end

    function acot(x)
        argumentCheck(x, "number")
        return math.atan(1/x)
        
    end

    function sech(x)
        argumentCheck(x, "number")
        return 1/math.cosh(x)
        
    end

    function csch(x)
        argumentCheck(x, "number")
        return 1/math.sinh(x)
        
    end

    function coth(x)
        argumentCheck(x, "number")
        return 1/math.tanh(x)
        
    end

    function asinh(x)
        argumentCheck(x, "number")
        return math.log(x + (x*x + 1)^0.5)
        
    end

    function acosh(x)
        argumentCheck(x, "number")
        return math.log(x + (x*x - 1)^0.5)
        
    end

    function atanh(x)
        argumentCheck(x, "number")
        return math.log((1 + x)/(1 - x))/2
        
    end

    function acsch(x)
        argumentCheck(x, "number")
        return asinh(1/x)
        
    end

    function asech(x)
        argumentCheck(x, "number")
        return acosh(1/x)
        
    end

    function acoth(x)
        argumentCheck(x, "number")
        return atanh(1/x)
        
    end
end

--[[
Todo:
    - New (better) RNG ?

    - Matrices
    - Moar vectors (higher-d)
    - Complex Numbers
    - Ratio type (fraction)
]]
