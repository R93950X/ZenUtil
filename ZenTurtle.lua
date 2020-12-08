if not ZenSilent then
    print("ZenTurtle 0.0 By TheZen")
    
end

function forward(distance)
    -- Verify & Format Arguments
    if type(distance) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radicand), 2)
    end
    
    -- function
    for i = 1, a do
        if turtle.detect() then
            return false
            
        else
            turtle.forward()
            
        end
        
    end
    
    return true
    
end

function right(distance)
    -- Verify & Format Arguments
    if type(distance) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radicand), 2)
    end
    
    -- function
    turtle.turnRight()
    for i = 1, a do
        if turtle.detect() then
            turtle.turnLeft()
            return false
            
        else
            turtle.forward()
            
        end
        
    end
    turtle.turnLeft()
    
    return true
    
end

function left(distance)
    -- Verify & Format Arguments
    if type(distance) ~= "number" then
        error("Argument 1 - expected type: number, got "..type(radicand), 2)
    end
    
    -- function
    turtle.turnLeft()
    for i = 1, a do
        if turtle.detect() then
            turtle.turnRight()
            return false
            
        else
            turtle.forward()
            
        end
        
    end
    turtle.turnRight()
    
    return true
    
end

function turn180()
    turtle.turnLeft()
    turtle.turnLeft()
end