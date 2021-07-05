-- List of files for the user to select from
local files = {
    ".LoadAPIs.lua",
    "ZenFormat.lua",
    "ZenMath.lua",
    "ZenPic.lua",
    "ZenText.lua",
    "ZenTable.lua"
}

-- List of branches for the user to select from
local branches = {
    ["main"] = true,
    ["beta"] = true
}

-- Argument interpreter from https://github.com/LDDestroier/CC
local function interpretArgs(tInput, tArgs)
	local output = {}
	local errors = {}
	local usedEntries = {}
	for aName, aType in pairs(tArgs) do
		output[aName] = false
		for i = 1, #tInput do
			if not usedEntries[i] then
				if tInput[i] == aName and not output[aName] then
					if aType then
						usedEntries[i] = true
						if type(tInput[i+1]) == aType or type(tonumber(tInput[i+1])) == aType then
							usedEntries[i+1] = true
							if aType == "number" then
								output[aName] = tonumber(tInput[i+1])
                                
							else
								output[aName] = tInput[i+1]

							end

						else
							output[aName] = nil
							errors[1] = errors[1] and (errors[1] + 1) or 1
							errors[aName] = "expected " .. aType .. ", got " .. type(tInput[i+1])

						end

					else
						usedEntries[i] = true
						output[aName] = true

					end

				end

			end

		end

	end
	for i = 1, #tInput do
		if not usedEntries[i] then
			output[#output+1] = tInput[i]

		end

	end
	return output, errors

end

local argData = {
    ["-d"] = "string",
    ["-b"] = "string",
    ["-o"] = false
}

local argList = interpretArgs({...}, argData)

local installDir = "/"..(argList["-d"] or "ZenUtil")
local branch = argList["-b"] or "main"
local overwrite = argList["-o"] or false

argErrors = {}
if not branches[branch] then
    table.insert(argErrors, "Invalid branch \""..branch.."\"")

end
if fs.exists(installDir) and not overwrite then
    table.insert(argErrors, "\""..installDir.."\" already exists")

end

if #argErrors > 0 then
	local errList = ""
	for k,v in pairs(argErrors) do
        errList = errList..v.."\n"

    end
    error(errList)

end

-- Ask user which files they want
local toDownload = {}
term.clear()
term.setCursorPos(1,1)
if branch == "main" then
    print("ZenUtil 0.03 Installer\n@ "..installDir.."\n")

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

-- Download & Install

if fs.exists(installDir) then
    fs.delete(installDir)
end

for i, v in pairs(toDownload) do
    write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..branch.."/"..v.."... ")
    local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..branch.."/"..v)
    if website then 
        print("Success!")
        local file = fs.open(installDir.."/"..v,"w")
        file.write(website.readAll():gsub("_BRANCH_",branch))
        website.close()
        file.close()
        print("Downloaded as "..installDir.."/"..v)
        
    else
        print("Connection failed!")
        
    end
    
end

--[[
Todo:
    - Somehow unify the argument check function in a modular utility pack
    
    - Completely rewrite installer
        - Make a UI
        - Create Update functionality
]]
