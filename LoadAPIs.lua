_G.ZenUtil = {}
ZenUtil.InstallDir = "/"..fs.getDir(shell.getRunningProgram())
local APIS = fs.list(ZenUtil.InstallDir)

for i = 1,#APIS do
    if APIS[i] ~= "LoadAPIs.lua" then
        os.loadAPI("/"..ZenUtil.InstallDir.."/"..APIS[i])
        
    end
    
end

function ZenUtil.update()
    for i, v in pairs(APIS) do
        write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v.."... ")
        local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/main/"..v)
        print("Success.")
        local file = fs.open("/ZenUtil/"..v,"w")
        file.write(website.readAll())
        website.close()
        file.close()
        print("Downloaded as /ZenUtil/"..v)
        
    end
end