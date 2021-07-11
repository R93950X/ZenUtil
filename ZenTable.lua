if not ZenUtil.silent then
    print("ZenTable 0.1 By TheZen")
    
end

local function argumentCheck(...)
    local Args = {...}
    for i = 2, #Args, 2 do
        if type(Args[i-1]) ~= Args[i] then
            error("Argument "..(i/2).." - expected type: "..Args[i]..", got "..type(Args[i-1]), 2)

        end

    end

end

function shuffle(tbl)
    argumentCheck(tbl, "table")
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]

    end

end

function reverse(tbl)
    argumentCheck(tbl, "table")
    local pos1 = 1
    local pos2 = #tbl
    while pos1 < pos2 do
        tbl[pos1], tbl[pos2] = tbl[pos2], tbl[pos1]
        pos1 = pos1 + 1
        pos2 = pos2 - 1

    end
    
end

function deepCopy(tbl)
    local clone = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            clone[k] = deepCopy(v)
        else
            clone[k] = v
        end
    end
    return clone
end

--[[
Todo:
    None!
]]
