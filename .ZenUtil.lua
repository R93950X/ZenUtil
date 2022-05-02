local args = {...}
local mode = 0
for i, v in pairs(args) do
    if v == "-u" then
        mode = 1
    end
end

if mode == 0 then
    local installDir = settings.get("ZenUtil.installDir")
    local modules = settings.get("ZenUtil.modules")
    package.path = package.path..";"..installDir.."/?.lua"
    for i, module in ipairs(modules) do
            _G[module:gsub(".lua","")] = require(module:gsub(".lua",""))
    end
elseif mode == 1 then
    shell.run("wget run https://raw.githubusercontent.com/R93950X/ZenUtil/"..settings.get("ZenUtil.branch").."/.Install.lua")
end

--[[
Todo:
    None!
]]  
