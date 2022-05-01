local version = "0.2b"
local selectedTab = "Files"
local selectedBranch = settings.get("ZenUtil.branch") or "main"
local installDir = settings.get("ZenUtil.installDir") or "/ZenUtil"
local installDirOld = settings.get("ZenUtil.installDir")
local files = {}
local selectedFiles = {}
local modifyMode = 2
local installedModulesOld = fs.exists(installDir) and fs.list(installDir)
if installedModulesOld then
    for i, v in pairs(settings.get("ZenUtil.modules")) do
        installedModulesOld[v] = true
        selectedFiles[v] = 2
    end
    modifyMode = 3
end
local QUIT, INSTAll, Branches
local w, h = term.getSize()

local function refreshFiles()
    files = {}
    local handle = http.get("https://api.github.com/repos/R93950X/ZenUtil/contents?ref="..selectedBranch)
    if handle then
        data = textutils.unserialiseJSON(handle.readAll())
        for i, v in pairs(data) do
            if not (v.name == ".Install.lua" or v.name == ".gitattributes") then
                table.insert(files, v.name)
                if not selectedFiles[v.name] then
                    selectedFiles[v.name] = 0
                end
            end
        end
    else
        error("Connection failed!")
    end
end

local function refreshBranches()
    branches = {}
    local handle = http.get("https://api.github.com/repos/R93950X/ZenUtil/branches")
    if handle then
        local data = textutils.unserialiseJSON(handle.readAll())
        local resetSelection = true
        for i, v in pairs(data) do
            if selectedBranch == v.name then
                resetSelection = false
            end
            table.insert(branches, v.name)
        end
    else
        error("Connection failed!")
    end
end

local fileColors = {
    [0] = {colors.red, colors.white}, {colors.green, colors.white}, {colors.yellow, colors.black}
}

local tab = {
    Files = function()
        term.setCursorPos(1,2)
        for i, v in pairs(files) do
            term.setBackgroundColor(fileColors[selectedFiles[v]][1])
            term.setTextColor(fileColors[selectedFiles[v]][2])
            write("  "..v)
            write(string.rep(" ", w).."\n")
        end
        local event, button, x, y
        repeat
            event, button, x, y = coroutine.yield()
        until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #files
        selectedFiles[files[y-1]] = (selectedFiles[files[y-1]]+1)%modifyMode
        if modifyMode == 3 and not installedModulesOld[files[y-1]] and selectedFiles[files[y-1]] == 0 then
            selectedFiles[files[y-1]] = 1
        end
    end,
    Branches = function()
        term.setCursorPos(1,2)
        for i, v in pairs(branches) do
            if v == selectedBranch then
                term.setBackgroundColor(colors.lime)
            end
            write("  "..v)        
            write(string.rep(" ",w).."\n")
            term.setBackgroundColor(colors.lightGray)
        end
        local event, button, x, y
        repeat
            event, button, x, y = coroutine.yield()
        until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #branches
        selectedBranch = branches[y-1]
        sleep(1/20)
        refreshFiles()
    end,
    Settings = function()
        term.setCursorPos(1,2)
        write("Install @: "..installDir)        
        write(string.rep(" ",w).."\n")
        local event, button, x, y
        repeat
            event, button, x, y = coroutine.yield()
        until event == "mouse_click" and button == 1 and y > 1 and y <= 1 + #branches
        if y == 2 then
            term.setCursorPos(13,2)
            term.setBackgroundColor(colors.lightGray)
            write(string.rep(" ",w))
            term.setCursorPos(13,2)
            installDir = "/"..read()
        end
    end,
    Exit = function()
        QUIT = true
    end,
    Install = function()
        QUIT = true
        INSTALL = true
    end
}

local tabOrder = {"Files", "Branches", "Settings", "Install", "Exit"}
local function tabsBar()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.gray)
    write(" ")
    for i, v in pairs(tabOrder) do
        if v == selectedTab then
            term.setBackgroundColor(colors.blue)
        elseif v == "Exit" then
            term.setBackgroundColor(colors.red)
        elseif v == "Install" then
            term.setBackgroundColor(colors.lightBlue)
        end
        write(v)
        term.setBackgroundColor(colors.gray)
        write("  ")
    end
    write(string.rep(" ", w))
    local event, button, x, y
    repeat
        event, button, x, y = coroutine.yield()
    until event == "mouse_click" and button == 1 and y == 1
    if x >= 2 and x <= 6 then
        selectedTab = "Files"
    elseif x >= 8 and x <= 15 then
        selectedTab = "Branches"
    elseif x >= 18 and x <= 25 then
        selectedTab = "Settings"
    elseif x >= 28 and x <= 34 then
        selectedTab = "Install"
    elseif x >= 37 and x <= 40 then
        selectedTab = "Exit"
    end
    term.setBackgroundColor(colors.lightGray)
    term.clear()
end

function banner()
    term.setBackgroundColor(colors.gray)
    term.setCursorPos(1,h)
    write("ZenUtil Version "..(selectedBranch == "main" and version or (version.." "..selectedBranch)).." Installer")
    write(string.rep(" ",w))
    sleep(10^6)
end

refreshFiles()
refreshBranches()
term.setBackgroundColor(colors.lightGray)
term.clear()
while not QUIT do
    parallel.waitForAny(tab[selectedTab], tabsBar, banner)
end
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

local installedModules = {}

if INSTALL then
    for i, v in pairs(selectedFiles) do
        if v == 1 then
            write("Connecting to https://raw.githubusercontent.com/R93950X/ZenUtil/"..selectedBranch.."/"..i.."... ")
            local website = http.get("https://raw.githubusercontent.com/R93950X/ZenUtil/"..selectedBranch.."/"..i)
            if website then 
                print("Success!")
                local file = fs.open(fs.combine(installDir,i),"w")
                file.write(website.readAll():gsub("_BRANCH_",selectedBranch))
                website.close()
                file.close()
                print("Downloaded as "..fs.combine(installDir,i))

            else
                print("Connection failed!")

            end

        elseif modifyMode == 3 and v == 0 then
            fs.delete(fs.combine(installDirOld, i))

        end
        
        if i ~= ".ZenUtil" and (v == 1 or v == 2)  then
            table.insert(installedModules, i)

        end
    end

    settings.set("ZenUtil.branch", selectedBranch)
    settings.set("ZenUtil.installDir", installDir)
    settings.set("ZenUtil.modules", installedModules)
    settings.save()

    sleep(0.5)
    term.clear()
    term.setCursorPos(1,1)
end

--[[
Todo:    
    None!
]]