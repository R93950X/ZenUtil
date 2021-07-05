local args = {...}
for i = 1, #args do
    args[i] = args[i].." "
    
end
args = table.concat(args)

-- List of files for the user to select from
local files = {
    ".LoadAPIs.lua",
    "ZenFormat.lua",
    "ZenMath.lua",
    "ZenPic.lua",
    "ZenText.lua",
    "ZenTable.lua"
}

local branch = string.find(args,"-b") and "beta" or "main"

local installDir1, installDir2 = args:find("-d [%w/]+")
local installDir
if (installDir2 or 0) - (installDir1 or 0) >= 4 then
    installDir = "/"..args:sub(installDir1+3,installDir2)

else
    installDir = "/ZenUtil"

end

-- Ask user which files they want
local toDownload = {}
term.clear()
term.setCursorPos(1,1)
if branch == "main" then
    print("ZenUtil 0.03 Installer\n")

else
    print("ZenUtil 0.04 "..branch.. " Installer\n@ "..installDir.."\n")

end

for i, v in pairs(files) do
    local input = 0
    print("Do you wish to install "..v.."? [Y/N]")
    repeat
        input = select(2, os.pullEvent("key"))
        
    until input == keys.y or input == keys.n
    if input == keys.y then
        table.insert(toDownload, v)
        
    end
    
end

-- Download files
for i, v in pairs(toDownload) do
    write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..branch.."/"..v.."... ")
    local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..branch.."/"..v)
    print("Success!")
    local file = fs.open(installDir.."/"..v,"w")
    file.write(website.readAll():gsub("_BRANCH_",branch))
    website.close()
    file.close()
    print("Downloaded as "..installDir.."/"..v)
    
end

--[[
Todo:
    - Actually check if connections were sucessful
    - Somehow unify the argument check function in a modular utility pack
    - Make a UI
    - Create Update functionality
]]
