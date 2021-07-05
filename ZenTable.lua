if not ZenUtil.silent then
    print("ZenTable 0.01 By TheZen")
    
end

local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

function shuffle(table)
    argumentCheck(table, "table")
    for i = #table, 2, -1 do
        local j = math.random(i)
        table[i], table[j] = table[j], table[i]

    end

end

function reverse(table)
    argumentCheck(table, "table")
    local pos1 = 1
    local pos2 = #table
    while pos1 < pos2 do
        table[pos1], table[pos2] = table[pos2], table[pos1]
        pos1 = pos1 + 1
        pos2 = pos2 - 1

    end
    
end

--[[
Todo:
    None!
]]
