if not ZenSilent then
    print("ZenMath 0.03 By TheZen")
    
end 

local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

do -- Basic Functions
    function root(radicand, root)
        -- Verify & Format Arguments
        argumentCheck(radicand, "number", root, "number")
        
        -- Function
        return radicand ^ (1 / root)
        
    end

    function log(value, base)
        -- Verify & Format Arguments
        argumentCheck(value, "number", base, "number")

        --Function
        return math.log(value)/math.log(base)

    end

end

do -- Circle Functions
    function areaOfCircle(radius)
        -- Verify & Format Arguments
        argumentCheck(radius, "number")
        
        -- Function
        return math.pi * radius * radius
        
    end

    function circumferenceOfCircle(radius)
        -- Verify & Format Arguments
        argumentCheck(radius, "number")
        
        -- Function
        return math.pi * radius * 2
        
    end

end

do -- Statistics 
    function sum(...)   
        -- Verify & Format Arguments
        local values = {...}
        values = type(values[1]) == "table" and values[1] or values
        
        for i, v in pairs(values) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        -- Function
        local sum = 0
        for i, v in pairs(values) do
            sum = sum+v
        end
        
        return sum
        
    end

    function mean(...)
        -- Verify & Format Arguments
        local values = {...}
        values = type(values[1]) == "table" and values[1] or values
        
        for i, v in pairs(values) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        -- Function
        local sum = sum(values)
        
        return sum/#values
        
    end

    function mode(...)
        -- Verify & Format Arguments
        local values = {...}
        values = type(values[1]) == "table" and values[1] or values
        
        for i, v in pairs(values) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        -- Function
        local Counts = {}
        for i, v in pairs(values) do
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
        -- Verify & Format Arguments
        local values = {...}
        values = type(values[1]) == "table" and values[1] or values
        
        for i, v in pairs(values) do
            if type(v) ~= "number" then
                error("Argument "..i.." - expected type: number, got "..type(v), 2)
                
            end
            
        end
        
        -- Function
        table.sort(values)
        
        return #values % 2 == 0 and (values[#values/2]+values[#values/2+1])/2 or (values[#values/2+0.5])
        
    end
end

do -- Trigonometry
    function sec(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")

        --Function
        return 1/math.cos(x)
        
    end

    function csc(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return 1/math.sin(x)
        
    end

    function cot(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return 1/math.tan(x)
        
    end

    function asec(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.acos(1/x)
        
    end

    function acsc(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.asin(1/x)
        
    end

    function acot(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.atan(1/x)
        
    end

    function sech(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return 1/math.cosh(x)
        
    end

    function csch(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return 1/math.sinh(x)
        
    end

    function coth(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return 1/math.tanh(x)
        
    end

    function asinh(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.log(x + (x^2 + 1)^0.5)
        
    end

    function acosh(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.log(x + (x^2 - 1)^0.5)
        
    end

    function atanh(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return math.log((1+x)/(1-x))/2
        
    end

    function acsch(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return asinh(1/x)
        
    end

    function asech(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return acosh(1/x)
        
    end

    function acoth(x)
        -- Verify & Format Arguments
        argumentCheck(x, "number")
        
        --Function
        return atanh(1/x)
        
    end
end

--[[
Todo:
    None!
]]