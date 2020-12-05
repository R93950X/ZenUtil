if not ZenSilent then
    print("ZenMath 0.01c By TheZen")
    
end

function root(radicand, root)
    -- Verify & Format Arguments
    if type(radicand) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radicand), 2)
        
    elseif type(root) ~= "number" then
        error("Argument 2 - expected type: number, got "..type(root), 2)
        
    end
    
    -- Function
    
    return radicand ^ (1 / root)
    
end

function areaOfCircle(radius)
    -- Verify & Format Arguments
    if type(radius) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radius), 2)
        
    end
    
    -- Function
    
    return math.pi * radius ^ 2
    
end

function circumferenceOfCircle(radius)
    -- Verify & Format Arguments
    if type(radius) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radius), 2)
        
    end
    
    -- Function
    
    return math.pi * radius * 2
    
end

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

--[[
Todo:
    None!
]]