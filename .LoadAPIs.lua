_G.ZenUtil = {}
ZenUtil.branch = "_BRANCH_"
ZenUtil.installDir = "/"..fs.getDir(shell.getRunningProgram())
local APIS = fs.list(ZenUtil.installDir)

for i = 1,#APIS do
    if APIS[i]:sub(1,1) ~= "." then
        os.loadAPI("/"..ZenUtil.installDir.."/"..APIS[i])
        
    end
    
end

function ZenUtil.update()
    for i, v in pairs(APIS) do
        write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..ZenUtil.branch.."/"..v.."... ")
        local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..ZenUtil.branch.."/"..v)
        print("Success.")
        local file = fs.open(ZenUtil.installDir.."/"..v,"w")
        file.write(website.readAll():gsub("_BRANCH_",ZenUtil.branch))
        website.close()
        file.close()
        print("Downloaded as /"..ZenUtil.installDir.."/"..v)
        
    end
end

function ZenUtil.modify()
    local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/main/.Install.lua")
    loadstring(website.readAll())()
end

--[[
Todo:
    - ZenUtil.modify()
        - Replace with execution of .Install
            - ^ will allow for Beta branch
            - ^ will allow for removal of APIs
    
    - Test installDir functionality
]]  
