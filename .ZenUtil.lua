_G.ZenUtil = {
    branch = settings.get("ZenUtil.branch"), -- move to system settings
    installDir = settings.get("ZenUtil.installDir"), -- move to system settings
    modules = settings.get("ZenUtil.modules"), -- move to system settings
    update = function() -- script parameters
        shell.run("wget run https://raw.githubusercontent.com/R93950X/ZenUtil/"..ZenUtil.branch.."/.Install.lua")
    end
}

for i, module in ipairs(ZenUtil.modules) do
        os.loadAPI("/"..ZenUtil.installDir.."/"..module)
end

--[[
Todo:
    None!
]]  
