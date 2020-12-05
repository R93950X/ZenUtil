if not ZenSilent then
    print("ZenPeripheral 0.01b By TheZen")
    
end

function listType(peripheralType)
    -- Verify & Format Arguments
    if type(peripheralType) ~= "string" then
        error("Argument 1 - expected type: string, got "..type(peripheralType), 2)
        
    end
    
    -- Function
    peripherals = peripheral.getNames()
    output = {}
    for i, v in pairs(peripherals) do
        if peripheral.getType(v) == peripheralType then
            table.insert(output, v)
            
        end
        
    end
    
    return output
end

--[[
Todo:
    None!
]]