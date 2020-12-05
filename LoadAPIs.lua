ZenUtil.InstallDir = "/"..fs.getDir(shell.getRunningProgram())
local APIS = fs.list(ZenUtil.InstallDir)

for i = 1,#APIS do
    if APIS[i] ~= "LoadAPIs" then
        os.loadAPI("/"..ZenUtil.InstallDir.."/"..APIS[i])
        
    end
    
end