local expect = require "cc.expect"
local deepCopy
deepCopy = function(tbl)
    expect(1, tbl, "table")
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
return {
    shuffle = function(tbl)
        expect(1, tbl, "table")
        for i = #tbl, 2, -1 do
            local j = math.random(i)
            tbl[i], tbl[j] = tbl[j], tbl[i]
        end
    end,
    reverse = function(tbl)
        expect(1, tbl, "table")
        local pos1 = 1
        local pos2 = #tbl
        while pos1 < pos2 do
            tbl[pos1], tbl[pos2] = tbl[pos2], tbl[pos1]
            pos1 = pos1 + 1
            pos2 = pos2 - 1
        end
    end,
    deepCopy = deepCopy
}
--[[
Todo:
    None!
]]
