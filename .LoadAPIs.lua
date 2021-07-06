_G.ZenUtil = {}
if ... == "true" then
    ZenUtil.silent = true

end
ZenUtil.branch = "_BRANCH_"
ZenUtil.installDir = "/"..fs.getDir(shell.getRunningProgram())
ZenUtil.files = fs.list(ZenUtil.installDir)

for i = 1,#ZenUtil.files do
    if ZenUtil.files[i]:sub(1,1) ~= "." then
        os.loadAPI("/"..ZenUtil.installDir.."/"..ZenUtil.files[i])
        
    end
    
end

function ZenUtil.update()
    shell.run("wget run https://raw.githubusercontent.com/R93950X/ZenUtil/"..branch.."/Install.lua")
    
end

--[[
Todo:
    None!
]]  
