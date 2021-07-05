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
    for i, v in pairs(ZenUtil.files) do
        write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..ZenUtil.branch.."/"..v.."... ")
        local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..ZenUtil.branch.."/"..v)
        if website then
            fs.delete(ZenUtil.installDir.."/"..v)
            print("Success!")
            local file = fs.open(ZenUtil.installDir.."/"..v,"w")
            -- using "_BRA".."NCH_" to prevent the string itself from being caught in the gsub()
            file.write(website.readAll():gsub("_BRA".."NCH_",ZenUtil.branch))
            website.close()
            file.close()
            print("Downloaded as "..ZenUtil.installDir.."/"..v)
            
        else
            print("Connection failed!")
            
        end
        
    end
    
end

--[[
Todo:
    - ZenUtil.update()
        - Replace with execution of .Install

            - ^ will allow for removal of APIs
]]  
