local args = {...}
local installDir = settings.get("ZenUtil.installDir")

if not args[1] then
    local modules = settings.get("ZenUtil.modules")
    package.path = package.path..";"..installDir.."/?.lua"
    for i, module in ipairs(modules) do
            _G[module:gsub(".lua","")] = require(module:gsub(".lua",""))
    end
elseif args[1] == "-u" then
    shell.run("wget run https://raw.githubusercontent.com/R93950X/ZenUtil/"..settings.get("ZenUtil.branch").."/.Install.lua")
elseif args[1] == "-r" then
    fs.delete(installDir)
    settings.set("ZenUtil.branch", nil)
    settings.set("ZenUtil.modules", nil)
    settings.set("ZenUtil.installDir", nil)
    settings.save()
end

--[[
Todo:
]]  
