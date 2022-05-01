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
    for i, module in ipairs(modules) do
            os.loadAPI("/"..installDir.."/"..module)
    end
elseif mode == 1 then
    shell.run("wget run https://raw.githubusercontent.com/R93950X/ZenUtil/"..settings.get("ZenUtil.branch").."/.Install.lua")
end

--[[
Todo:
    None!
]]  
